Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A433B7849D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHVTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHVTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:01:50 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13379CC;
        Tue, 22 Aug 2023 12:01:48 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MIguor009366;
        Tue, 22 Aug 2023 19:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=oKAZ9q0RaK3yb/4NtDr0DjmIcsqhqUap+U1BLhhbwj4=;
 b=FCDaGW0ul3ZHeDfCYca5m3CgH8rnEO7lx1yaTykoMxx/is0aXhF5u/SNQIJlAeiw2+73
 JCTyqx2Sg4zXH439gxSLX4EbExQhPVU1XW9Mlt7j4tEcDEp/UxH9o93B/K3HQ90hKbMK
 mVbt1U45ZscdJvbqFyIJMUulbHSykX5HNTlVwQFctIUDwVoMulgK4/jmpCmVvLw3RaEV
 /vrfFgje2hsZSbc15KLnpSPzdEPOWrtZp84yqOJV7Xnv3hQB9j/vwNYrjt9iNF0FbmaT
 aUcohK4IR+iR3jvRgxd/2DiHTAT9HWMT3AaDRTbeXU9IkDYSwQHlFXlsoVIp4eRM/cLj NQ== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sn2hm05x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 19:01:28 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 44554801AC4;
        Tue, 22 Aug 2023 19:01:27 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 22 Aug 2023 07:00:52 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 22 Aug 2023 07:00:51 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 22 Aug 2023 07:00:51 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 22 Aug 2023 07:00:51 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3FdCe942xyXI0QuuaxZth+u6YNLCuUUpD3sTMMXYsD4PmphSGZ0T4xGWF7b61KXxZWyOzx0Y8tLehtR2t9DkTotIQc8HbAbu+AbKdlZzBF/go8KT4HxIuLDDK2nYUeLbc/NDMGeflvVS06oZz9ag2y1WV+mBoTOYils6XW0PhMA747VuT84wHe6xqdcsbvKAv1J8iK6mnGXpWWXIrTeFlj22le9EXsX0K9kcixfDOFxq8o775rSARKRBcsJE1NQHD2OccaIWJN3pqao7zk2EO5+uNLpda6+W4VGu241zyEViLENAV832J17/bJTromu84RRvqN7L5yO/sUh9bL0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKAZ9q0RaK3yb/4NtDr0DjmIcsqhqUap+U1BLhhbwj4=;
 b=nNuimiCydfrHv0qZNDvmQDgIGEkkDJ3pvFm7YKhmADSOHCZLM2ZNWCcjXkFTa6vSbka+Vc4MfqASGnvgpNNmstDY0h9265P8AMgFY+zBsPJgMzBkQErpn04ls/DpZnk2brIRGnTw+PhmyD5TV4SdonMKLW31tzSPlz2SpbvBs7zjjrXdj9jK2hHvHPigTnrlNu+05BCAlOtIFvss1VZ8ZX4sNj5Be+J5L9ybo04L8cF40XN0/CYyO2F3qzXnyhfPr4jCtO37SlPJUCw7tTrm6rJoPzZWfvIcgzevtxHGzGnE+6lfPPozsxJvXkQz3Y7+XrNHQ7I8qYxZzmqhSQVBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 LV3PR84MB3556.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 19:00:50 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 19:00:50 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Topic: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Index: AQHZ0Ixvto7vnAASrEiTAeghAafYu6/tuDUAgAJzHICAAGX0gIAFz7wA
Date:   Tue, 22 Aug 2023 19:00:49 +0000
Message-ID: <CF9BD927-B788-4554-B246-D5CC6D06258F@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
 <1b8058e1-6e7f-4a4a-a191-09a9b8010e0a@lunn.ch>
In-Reply-To: <1b8058e1-6e7f-4a4a-a191-09a9b8010e0a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.76.23081101
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|LV3PR84MB3556:EE_
x-ms-office365-filtering-correlation-id: a4152bcd-34fb-4004-4a2a-08dba34219da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ykuw3rrJJf/aIBjG+mlfQUZTRQlxweu+2JCnfHmU5GaTMFq/x98f3qhKCKGbLD0A34Mw6Ce/wWl/oxA8x49FNBgZfoqNQZqrunMxDLyBqrP+qBJMuS1fEFoWLP1R8J+0hM11LH1P0z0RWPMdqQCE3uCzJ4D8bB3HrT+xLQ+HHtG4Mhsfm3tCa7S0LI4k9M1BwLiWV/xD/wfEcIkk0IOK9JTJgpZZzM9haBwVgi+dKs1F2nT1lQgohg8urPNMWg7Um2mLlDqg+svxOGtDl0nw+cWp962NGmoYA3OmLvfHdKV72/eYYHUID4LxwCo0xdlbFcf7Xcy2RxcU26kGY2IQ8f4AYlZbDREKAVth4sUbr5LogzoLNz4vCmTVlRq9dvT77PYOlu8mAcX9kpapHTR/sYm988YGH0eoK8u+kVXxxHq/WJsVVEkK3zLlv57nIS67NB59JHTVps831f9Gwzbm3ez1aYNyttQfp1wR81JVx0yQ2UssR2FroJYPgE8Gnedhh5atEBttM8Sm/2rf3Als0pSlUkjxPEOPRodtOJl127KE5M/gsBDGQsZAeGV6pmu3nZnIl3QvuF+uz/44vWbSGV2rZlXJgoee+kBbdDXCMPOG+SksHTRYAmmmB1JEBH/AUj6FpPRlj7hX5JlAlLRE9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(2906002)(4744005)(7416002)(38070700005)(38100700002)(6506007)(6486002)(5660300002)(33656002)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(64756008)(6512007)(6916009)(54906003)(76116006)(66556008)(66446008)(66476007)(82960400001)(478600001)(122000001)(71200400001)(36756003)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFVTNENGb0tTekhsQ21ZWFNndHJXLzJNOGpvNFNpTDdUMm9FZUdpU0txWlJ6?=
 =?utf-8?B?TksyWURZeFE4NHdCRHlCZ0NDbVMyWmlhRldxeFBEUFlkR0hkQklLaUFyaFVP?=
 =?utf-8?B?M3Y4U2U2V3Nuem9mR2p5bi9aNkNGMDhLM0ZzTzJiTWNlSjBHOU4rVDl2MTJh?=
 =?utf-8?B?NSt4VHorQTYzdFZCNTJsZ3FYWERtbVEvNmRXdUFROEFQQVRDY2EzZDZ1M2pO?=
 =?utf-8?B?dEp2NXIwQVo1Y2JQMGNONE5IRWFTdENCMTV1UUpWZmVjaU4xQzJnNk1sMmtJ?=
 =?utf-8?B?bWdkRjBHZWpNdzMzR0FwTXFVSEVUeGZlUnUxbVB1N0FUN01WOGdPUDBVYy9r?=
 =?utf-8?B?WVQ4V1dxejYreSswZFJLUGR3czNwb0x3QkZPOVRaMHFZbEtIUXFqWFVpY2hv?=
 =?utf-8?B?eG9CbTZMTEpuMjgxMmhLMWpNSUg2SUpkYlNZQWVrRUpVNTNuL1ZtMWM4cm15?=
 =?utf-8?B?U3FGbGJUVDNGSGMwZks4V09zSUtCblNLUVppc0pWVzJOMGZiMnQ0dFlJb09G?=
 =?utf-8?B?aUQ4QkhERzc3TDFnTmdTQytoUHpYRll2R3NCMUlGTmU0S1lKdG91QlVLUm9k?=
 =?utf-8?B?enR2SEtOTXBuMENadVhNL3YrenI3MkE4VDg2K2RPWFJncXU3bU1idFZQWHBh?=
 =?utf-8?B?ZnNRRUxvMDNYK2VQblJPWkJnTHdQTVJpYW1BOFhoNEVGWUhlVlR2WXBPQUFz?=
 =?utf-8?B?cDJXdnBocGFFOGdmMG9yRTRmWWYwNnd3TURseDZoV0hTdi9FcXFxMlFTMFRi?=
 =?utf-8?B?Sy9OUWJNZ2NQZmN3OWpGYzVlai9CS0oraTNhRUlrUTZ6U3V1QmpEeFIvS3g1?=
 =?utf-8?B?Z0ZtWVJXa1RSckpKMUNxdFhjVUptWUhCUXJVZzU2ajZjeTR5Z2lWRGxvcExr?=
 =?utf-8?B?TU9MWFY2VnJOcm9LQ2VCNnpmbXBFODYwMDZDWGIzeTg1SjhYenB5ZS9DSFEz?=
 =?utf-8?B?NjFwRG1yaHlkZXpFa2xJeFdQNTZtYzh4ZjU5NGkvb1ZRUUNKVC9zbjRxUWRt?=
 =?utf-8?B?Q3UvVkpRWDFKNUh3ZTcwRFJ0OXRSRVIraUFtRlFCanNhVXhXS3FQajdRYzRy?=
 =?utf-8?B?WU83c1FaeHNTaW1USkZpUTFIMlRFaHZ4TTY3Z3BtZGxRdW03eWRnc0FRdDVE?=
 =?utf-8?B?WnovRlQyZ2tZelBKeFFGVHExUHcwV2lhWmp0cXRnUkExWmlMeGw0aHhpTXI4?=
 =?utf-8?B?USs0UmRwbU9XZmVWZHRSS3o1SXFLMFQ4NzFyOGFxWmZrWStjRmdxZTVOUVdW?=
 =?utf-8?B?VlR1cXpKQkJSbzFsUUMwZnloUG1SM2tlZEM0c2cwYW9YWEo0Q1dKZ2hlbnpL?=
 =?utf-8?B?R21TbTVhRGFObXg5RFdPQkNIakg5SWZRdG52ZVU3SnpNaFpzWC9PWEpyZEdQ?=
 =?utf-8?B?T3RFcEtyalVWRUZuWjVvbnRTUnBWdXdvQURuMk00NjZMeEVuajBhOTJUN0NR?=
 =?utf-8?B?YzBTcFptTThXMnBSd0NoK0FhWUNDM2huL09ZL0hwbG1KYXFrK2FCNXl4TDZM?=
 =?utf-8?B?NnZTb3R6d2kyZ2ZGaGVFN0VUcTY4dzE3aXJPejFSTVdlTTh6Z3RlY2s1ajg2?=
 =?utf-8?B?TEU3dERIS3g4Q2ppYnZUTE5zRDNodVBsUVNDaXBFbllLZHJYbDh1aEZSelV5?=
 =?utf-8?B?ZUtNRzB1MllsQ3FIaGc2ZHVJc2NFZlpKb3pHZkoxdkFMdnhtN3lQZHkzYVlN?=
 =?utf-8?B?NmdZQzdOZzBsQUh5dDBuczdCSXpwNXVLdlBHMXZUeHFSRlpQd1dneXdLWGMr?=
 =?utf-8?B?RG03RXpZcEQ3eXNkdjQreHJadUt2N3Z0NXBKY1FuRXNkbis0VXBaSXpQWk9Z?=
 =?utf-8?B?ZXhvUE5xc3RtMkkrOGZqU2h4cjlZR1hSbHplaTVmQWwvMndtV3lNSlNXRDlB?=
 =?utf-8?B?M2RKL2NEeEJWRFdlaWtoTXhzVGtQK1hFcEJxYWlpNnUzSWZrNnhyODN0ZUFz?=
 =?utf-8?B?dmJGaHVteGJrQmtFeXZwRTBYQ3BCa3Qxdi80dFI3SzNRUzZETmc1UFdUS0hO?=
 =?utf-8?B?QUJtcUpaZ0wzbXJVYlcrQVZFQXd4elorM255RlEyTzFvbUdmU3dKcU10MkVj?=
 =?utf-8?B?ZVNvL0R3Y3dSSGJnK0RIOWltcFdKWVNJOXdYa3FlNXcybGIyMG5PVERBMnV4?=
 =?utf-8?B?aGRnaFFNK1RJUDA4citIRHRsNTRsUnNJTHl6dmpMRzVXbS85aTRmQjcwcmNX?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AA6C8095CC0D4449ED4BE155D1273F6@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a4152bcd-34fb-4004-4a2a-08dba34219da
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 19:00:49.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MW95INikiy2CVfLBjIk9sreVytk5FaRLrAFSXTFrDJP5yaUhyMEokRAojtCqz//wMRkR7ZZpGWUgM6a7+CXErg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3556
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 1QwgEWlut9pmSGFHxKVzEjMF61bMwyrp
X-Proofpoint-GUID: 1QwgEWlut9pmSGFHxKVzEjMF61bMwyrp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_16,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=776
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308220151
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IDxpbmNsdWRlL25ldC9wYWdlX3Bvb2wvaGVscGVycy5oPg0KDQpIaSBBbmRyZXcsDQoNCkkg
Y2FuJ3Qgc2VlbSB0byBmaW5kIHRoaXMgZmlsZSBpbiBsaW51eCBtYXN0ZXIuIFdoZXJlIGlzIGl0
Pw0KDQo+IFRha2UgYSBsb29rIGF0IGRyaXZlci9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19t
YWluLmMgVGhhdA0KPiBkcml2ZXIvZGV2aWNlIGlzIG9mIHNpbWlsYXIgY29tcGxleGl0eSB0byB5
b3Vycy4gSXQgaGFkIGEgcmVjZW50DQo+IGNoYW5nZSBmcm9tIGl0cyBvd24gYnVmZmVyIG1hbmFn
ZW1lbnQgdG8gcGFnZSBwb29sLiBJdA0KPiBzdGFydGVkIHdpdGgNCg0KSSBoYXZlIGxvb2tlZCBv
dmVyIHRoaXMgZHJpdmVyIGFuZCBoYXZlIGEgY291cGxlIHF1ZXN0aW9ucw0KYWJvdXQgdGhlIHBh
Z2VzIGluIGdlbmVyYWwuDQoNCkhvdyBkbyBJIGRldGVybWluZSB3aGF0IHRoZSBjb3JyZWN0IHBv
b2wgc2l6ZSBzaG91bGQgYmUgZm9yIHRoZQ0KUlggYW5kIFRYPw0KDQpJIG11c3QgYWRtaXQgSSBh
bSBub3QgZmFtaWxpYXIgd2l0aCBYRFAuDQpJcyBpdCByZXF1aXJlZCBmb3IgdGhlIHBhZ2UgcG9v
bCBsaWJyYXJ5PyBEb2VzIGl0IHJlcXVpcmUgYW55IGtpbmQNCm9mIGhhcmR3YXJlIGVuYWJsZW1l
bnQ/IE9yIGlzIGl0IGp1c3QgcHVyZWx5IGNvZGU/DQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNr
IGFuZCBhc3Npc3RhbmNlLA0KDQotTmljayBIYXdraW5zDQoNCg==
