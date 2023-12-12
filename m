Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5F80EE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376352AbjLLN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376327AbjLLN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:57:56 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C659283;
        Tue, 12 Dec 2023 05:58:02 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCB4ROC028638;
        Tue, 12 Dec 2023 05:57:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=QYd5bjYjV0/In/ObfX01woXZaCdh8nZ4IvrilQlJmGY=; b=
        E9LwOahsvD4auAyq5N3649QolHCbLUa2P8riOEmowDL8YP9EnyQqginifshasq3C
        OENKzqy5d7wefVKMbsZChR78gcNIsHEU/4PPw8h7HnnM6NYKAqRgdHiaFZA9l/A0
        i3+SYylkQd7l/ZtuAqixe9penWkO3+835tU/4gGBjlbop4quUxQ0JtSmKhxGcPTe
        i3jHp3h9HsDh6dX5/YgPRVLCqPVw9gT7cYEvkKwKREZFGnN3WuEDwqOokiZc3Mtc
        YvOY6enZ62Lht4cFF+Xc7qQm7elGAfiV30O5jTlaFvB6h7hg3WxKdIswqZlvtndK
        NHrntdd1SxD5xbZn4F9hnQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uvmd4amsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 05:57:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gliH6yN9M3Iit+E7fwuqnkyjTDfQj+K30gK4T5K567+qC9qIMPzeJioZtpale4qvD5kw0b+AGLGTTsFCxbQooLpwWBt/TcFSxVpwUBCt7h/zrfPtLoKCkb1sI1CCJgSE7bh5hoGIv4CnsI4nfWf13q555aRUeCQwWhJg3/Ycti6sIC0MRyxknKq1b5r9nn3sKALLkm5i+k4iDXFVENJ3duKVqjZ/zWy56zFPVqXF+TEXAvc84rVF+3EfBpyBsWjxVW38PgldJZkY/MnUCorVXjUAaf2hzTmDOc/elwNxV4RcEtMqi0pSPoStUEwjrmSHItAipRzVJPNGqnAlsMMwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYd5bjYjV0/In/ObfX01woXZaCdh8nZ4IvrilQlJmGY=;
 b=f9HzlqXrrj7oyE2f55rOkuvLcGXA0gbhnMN9PhDlvIR1VlVJvmqRx/vVmvr0QxjVN2ifVnHXZWxxvYCv0L7+iSM1UT7u0zysOS4im3/5m9i/ZvxCIfsKVqJGowr97n2TdR4ywk8s5f1xWzoFIOuV3Xpvt28WAfVGm5iB6+EudPgNcK/J11CgkTluKjYWpLDugJeLRz9wTI8wu/gmjeqBrDFVg/Qj6V7tHpJbT5hXEVHKWGySOH0PfLFkyc9uR1+Fwu/Vg+fvEapH/S3vfWwGV4IyCaEr73S5Ajp49hCfHNs3jT9D94EcCCPX3MT0QzweIBnPUlYC0gxLeciazem8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 13:57:08 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%6]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 13:57:08 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        "sxwjean@me.com" <sxwjean@me.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] Documentation: kernel-parameters: remove
 noaliencache
Thread-Topic: [PATCH v3 1/4] Documentation: kernel-parameters: remove
 noaliencache
Thread-Index: AQHaKqb4anbYbwBo0UmeWCYF4YHaPbCkXvcAgAFRPjA=
Date:   Tue, 12 Dec 2023 13:57:08 +0000
Message-ID: <PH0PR11MB5192134D7768E364E286DD16EC8EA@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231209135203.303508-1-sxwjean@me.com>
 <20231209135203.303508-2-sxwjean@me.com>
 <0990dd35-30e5-4903-a243-767f27feb601@quicinc.com>
In-Reply-To: <0990dd35-30e5-4903-a243-767f27feb601@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|DM4PR11MB5359:EE_
x-ms-office365-filtering-correlation-id: 0ffcad50-5136-4ae9-a9ab-08dbfb1a3b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/1sEQ1S6U2wBJyaY9e5zZQIZocop+hXnko32YKZ1UdmGhKvuMecmRuquY2KoBkr2GXZIQDojIM3BN1/Iw45KCBKwg/ZfOc3zL5RtHfANAY811P3pS7Nti7DPOySS37Eewtn50UK0zZOBdIMsQ0/k8VUXgjxSachh87cu48C28fga5azbaST20fXAFOuRJAiS20wLUfzh2yWiMg7sQgfot2TPqXKC9ZpTreUUfPDAlJf4u3i9vUxFGz///GASKnSgpoFEfxwDEL6tCTM8CI4EH6GQc1Is4CAMFXJ+Y3msgR75f4PruqYVlAZYBEpHpIpOlM7SUQNCSisVUw+9+wtaboaLu6iVL/w1FyIk2SepE/TU7NoI/h0hsjwXkxOeq+diJjnG+yoKl2BFaPEQo/LLyRgvnG4r/R8LNZnc0JYJZgCOsId3kBb8oAj364eM+KVgioAA9XbdwLt9WzGyd42ZSmOSjgtY3JiFkfFIClbY/cyZ1HgJRVE0/g2dXTgM8cTdxtRvase1RkXhlU0+ccl7Oi9XZrAH9ZmXldugkkyn5LtCCTYuEEqBv/WAH+tzuNFK2kpyiRJH+Aewp6Xu8+xhIvMfifDiOgvlZgu7o5NfEWE5fLfDqW+qrEGpUYV1do/q8nhakWg5leSPA/Ii8n5mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(110136005)(64756008)(66946007)(76116006)(66556008)(316002)(66476007)(54906003)(53546011)(9686003)(7696005)(41300700001)(71200400001)(38070700009)(38100700002)(122000001)(86362001)(6506007)(33656002)(83380400001)(966005)(478600001)(2906002)(52536014)(66446008)(5660300002)(7416002)(55016003)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUJGdTEwdHkzdGJhZjE4eHlkK1ltOXE1SmhGV2V4S0pTamlaMmhJdzdhaHN4?=
 =?utf-8?B?T2RBckJXSDF0dk92dUluTmh0NHBFUGVnd0szcFJaVjZpQUsyYXgwK0JVTDE5?=
 =?utf-8?B?SEpNbFVBd1UrZGRrRC9qcDF4Um5YNGRscFA5LzNnUlJuZW9JOFFHOEZOMGFn?=
 =?utf-8?B?YWdzV3BEbU50YTlZdXBwN1VZSmRkOTNyZ1NBS1ZGSmliZy9PdGJnY3RpQ0lk?=
 =?utf-8?B?WnMxYTdnd2N2SVc0d3REWEFtTlJvS1RUTjFuMGM3Q2FqT1BjU0FDL0FUWiti?=
 =?utf-8?B?T3hyMEZrTG1aN1czMmxqK0dFdVAyeElVT2NHWGdCUTBJbmFZNnpkdVd5eUxn?=
 =?utf-8?B?Z1kzZnBFTlJVSHo0WjlHM2xnYloxWHp6VXZNUnB3VHV3UmQvaUdudm1kVHh1?=
 =?utf-8?B?b21hZGRTK2thY2pYMi9RMk41bGhCUEJJdEx3OXpkTWp0VGZoamNTYmF2VmJU?=
 =?utf-8?B?dklUZ1dYVUhzM3EwRHJ2dy9GcWRCNjdUbUYrMVRNaVpsSGQ3WklZWjZLNUxD?=
 =?utf-8?B?NFY2SlhTYktCNXl6SlNNenN1cDU0ZGNRM1FXVHVQdDh2RzYxVTdxTU5DK280?=
 =?utf-8?B?d0hSVjMrV3B5N3JwZ05QOU9vWktkOGkrZGMvMnM1djlOZy83SmJzeHNyY3Q4?=
 =?utf-8?B?TlRiT3F1aE9mTHBkSHN6RXZHUUlkVFQyaStHQ3hSbDd5QUs5cGZaU3JxNnMr?=
 =?utf-8?B?Q0Nub3kwNjF2bjRhOHhSblVtckxBbWFWZHhUc1F1UmlQTEFnTE9MQndtYlcx?=
 =?utf-8?B?Wm5YcXpscCtHTGNIVUpCczh4ekE5QTBEL21DdnBKWjE0ZzBkVnF2ekdPUmEz?=
 =?utf-8?B?RlVIRVN6S2pPTFJRZm1xcm9VMGtFcWYzdTUyUnJOOFhGNjlWRlZSOUxRMDZG?=
 =?utf-8?B?ZjJWdmw0SDNrWksrTVd5T0dIR0kvL2xYaW54cHJBZkYyeW1lcVRXREh5NWtm?=
 =?utf-8?B?YjYwcGplSEg4aGJjNWJnZXRPN0FpNEV1VGZIU1lWd1ZCTkVKTTFDTnlJT2VX?=
 =?utf-8?B?TkVwcWRUNzlmOTRGMXgvUnJOVFZ3dnI5Q2pkUlpHalBLNCtZN2VHcG1aUDV6?=
 =?utf-8?B?NlJ4VXRyL2pMRk5yaDVmQ1I5QmtKZFA0WjdJZHNQRmJYb3B4aDNqcG4rbkRm?=
 =?utf-8?B?TVFmc3JEOUtIeWVEQ0Rnc0ExTmtldVFOMWUrb0tFUXFsT0duM05TSDQwMlMr?=
 =?utf-8?B?U2M3VUZtdzBIMlhDVXUvVnBzbTJTaW1IaWxnTVFGa0JQdkJnS1RXcXROUWpU?=
 =?utf-8?B?RkNETXhhQjlOMHhqK2pZcTdmMHBTc01UeU9tYzRya3hKcG9FZmkwV3Z4OXFv?=
 =?utf-8?B?ak0zNmhSMjBWS2lja0pUeTBDVHd6QkJRYmJmd3JNclRVVmFZV25wOTBDelE0?=
 =?utf-8?B?Yk1sMWUybDJYTWJUNnJVaEppVkw5RXRyb1JlRWtzMXdUZDdNVnB5MTYrRUR5?=
 =?utf-8?B?cWJZNXpZWlZZcFUvbGdPUTQ4cTlLRHd2NHB6VHNsUU5XcWkwT05aemtac04r?=
 =?utf-8?B?VjlHb0R5U2lETlk3bmN3eTQxNVZwdXg0bXFkVDFpRmJ4OGJyRzFDMDA2blJQ?=
 =?utf-8?B?dm5tSHV4K1JCc2pxTVVvazVnNkhFRFVvUGcyaE1PeEpZRk1IaFVJeExnZEwz?=
 =?utf-8?B?NHpnQUlUeDlPQjZNY2J4WnF0bjZDcHZOYnpGSi85TXRCMmhIUUxya3hKUXFK?=
 =?utf-8?B?UUJRQThuYkxZRFpwaGc5TTIzZi9HQlVDVExlTG9OaGFCZHF2VTNxZTNLaXNt?=
 =?utf-8?B?bnkyaVdoMmxsWGY3WWJpdVR5SjVmWk5LclZsUWtpenZKaWRYVW9yRkFnMmww?=
 =?utf-8?B?eUoyQUpSdS9iemorNmZuQmJjUmdPUlNkc2xIY0lrMGFMSUo3SmhqQXNDL09X?=
 =?utf-8?B?VXY4aEI3d1VTc045KzhaMjNLSkhGVVdwbnoxRlJWR0dpMm14MzNzYVZJckZu?=
 =?utf-8?B?ZGc0Mzc3UjcxUk1sVkxxcUY5VnZLLzM3YVJJaFV1THFKUEhvQjFWVHR5cU5v?=
 =?utf-8?B?cTIzOTFzVS8rVGNJUTJmR3hlTTBsdVd3U1JkMVJ2SEdzd095S1plQUc3SDVC?=
 =?utf-8?B?WUMwZG5oUFNCVkExempScEZzNk5yRzN4SUVERldkVTdQMEFlSkRsU2VmazNN?=
 =?utf-8?B?ZzA4UTJ1d2x0SWZ3cEpNWUdiM1F5VnUzN2YvMTlaRU96Tjg3eVhxdE1HZDJ5?=
 =?utf-8?B?ZDFxbkkvM29XdUdBeUM3ZitoNGZwc1VnK3ZjcVNwV2ZHc1lDYkZybFZPcmVn?=
 =?utf-8?B?aXdQaGl1dytOUHpHNnVIS3E5QW53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffcad50-5136-4ae9-a9ab-08dbfb1a3b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 13:57:08.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkaUE5ANw2SRfZXGZgtY5TIiTOCDPAaH+ZhDa6RUH3vWyqXaMOGqvxsk01tWvve8BNOAWbgfs/F6HoKXbGM9QnkiYrjiFdfoHsTzPxzrSJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5359
X-Proofpoint-GUID: KZdb-0uAK6bgBb86C7Sx7Qc2D8uOc4Xd
X-Proofpoint-ORIG-GUID: KZdb-0uAK6bgBb86C7Sx7Qc2D8uOc4Xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=904 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogb3duZXItbGludXgtbW1A
a3ZhY2sub3JnIDxvd25lci1saW51eC1tbUBrdmFjay5vcmc+IE9uIEJlaGFsZiBPZiBKZWZmIEpv
aG5zb24NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTIsIDIwMjMgMTo0OCBBTQ0KPiBUbzog
c3h3amVhbkBtZS5jb207IHZiYWJrYUBzdXNlLmN6OyA0Mi5oeWV5b29AZ21haWwuY29tOyBjbEBs
aW51eC5jb207IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmcNCj4gQ2M6IHBlbmJlcmdAa2VybmVsLm9y
ZzsgcmllbnRqZXNAZ29vZ2xlLmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsNCj4gcm9tYW4u
Z3VzaGNoaW5AbGludXguZGV2OyBjb3JiZXRAbHduLm5ldDsga2Vlc2Nvb2tAY2hyb21pdW0ub3Jn
OyBhcm5kQGFybmRiLmRlOw0KPiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNvbmcsIFhpb25nd2VpIDxYaW9uZ3dlaS5Tb25nQHdpbmRy
aXZlci5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS80XSBEb2N1bWVudGF0aW9uOiBr
ZXJuZWwtcGFyYW1ldGVyczogcmVtb3ZlIG5vYWxpZW5jYWNoZQ0KPiANCj4gDQo+IE9uIDEyLzkv
MjAyMyA1OjUyIEFNLCBzeHdqZWFuQG1lLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBYaW9uZ3dlaSBT
b25nIDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20+DQo+ID4NCj4gPiBpbmNlIHNsYWIgYWxs
b2NhdG9yIGhhcyBhbHJlYWR5IGJlZW4gcmVtb3ZlZC4gVGhlcmUgaXMgbm8gdXNlcnMgb2YNCj4g
DQo+IHMvaW5jZS9TaW5jZS8NCj4gDQo+ID4gdGhlIG5vYWxpZW5jYWNoZWkgcGFyYW1ldGVyLCBz
byBsZXQncyByZW1vdmUgaXQuDQo+IA0KPiBzL25vYWxpZW5jYWNoZWkvbm9hbGllbmNhY2hlLw0K
DQpPaCwgdGhhbmtzLiBJIGdvdCB0aGUgZmx1IGxhc3Qgd2VlaywgIHNvbWV0aW1lcyBsb3N0IHBh
dGllbmNlIHRvIGNoZWNrIGl0IGNhcmVmdWxseSAuDQoNClJlZ2FyZHMsDQpYaW9uZ3dlaQ0KDQo+
IA0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBIeWVvbmdnb24gWW9vIDw0Mi5oeWV5b29AZ21haWwu
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4N
Cj4gPiBSZXZpZXdlZC1ieTogVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBYaW9uZ3dlaSBTb25nIDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20+
DQo+ID4gLS0tDQo+ID4gdjU6IENvbGxlY3QgUmV2aWV3ZWQtYnkgdGFnLg0KPiA+IHY0OiBDb2xs
ZWN0IFJldmlld2VkLWJ5IHRhZy4NCj4gPiB2MzogUmVtb3ZlIHRoZSBjaGFuZ2VzIGZvciBzbGFi
X21heF9vcmRlci4NCj4gPiB2MjogQWRkIGNoYW5nZXMgZm9yIHJlbW92aW5nICJub2FsaWVuY2Fj
aGUiLg0KPiA+ICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIzMTEyMjE0
MzYwMy44NTI5Ny0xLXN4d2plYW5AbWUuY29tLw0KPiA+IHYxOiBSZW1vdmUgc2xhYl9tYXhfb3Jk
ZXIuDQo+ID4gICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzIwMjMxMTIwMDkx
MjE0LjE1MDUwMi0yLXN4d2plYW5AbWUuY29tLw0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8IDQgLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vYWRt
aW4tDQo+IGd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+IGluZGV4IDY1NzMxYjA2MGUz
Zi4uOWY5NGJhZWIyZjgyIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3Vp
ZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPiBAQCAtMzc0MCwxMCArMzc0MCw2IEBADQo+
ID4gICAgICAgbm81bHZsICAgICAgICAgIFtYODYtNjQsUklTQ1ZdIERpc2FibGUgNS1sZXZlbCBw
YWdpbmcgbW9kZS4gRm9yY2VzDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGtlcm5lbCB0byB1
c2UgNC1sZXZlbCBwYWdpbmcgaW5zdGVhZC4NCj4gPg0KPiA+IC0gICAgIG5vYWxpZW5jYWNoZSAg
ICBbTU0sIE5VTUEsIFNMQUJdIERpc2FibGVzIHRoZSBhbGxvY2F0aW9uIG9mIGFsaWVuDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgIGNhY2hlcyBpbiB0aGUgc2xhYiBhbGxvY2F0b3IuICBTYXZl
cyBwZXItbm9kZSBtZW1vcnksDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGJ1dCB3aWxsIGlt
cGFjdCBwZXJmb3JtYW5jZS4NCj4gPiAtDQo+ID4gICAgICAgbm9hbGlnbiAgICAgICAgIFtLTkws
QVJNXQ0KPiA+DQo+ID4gICAgICAgbm9hbHRpbnN0ciAgICAgIFtTMzkwXSBEaXNhYmxlcyBhbHRl
cm5hdGl2ZSBpbnN0cnVjdGlvbnMgcGF0Y2hpbmcNCj4gDQoNCg==
