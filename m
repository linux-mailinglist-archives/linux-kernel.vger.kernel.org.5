Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55677F2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349326AbjHQJLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349320AbjHQJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:10:52 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A619A1;
        Thu, 17 Aug 2023 02:10:49 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37H6S0Ht019793;
        Thu, 17 Aug 2023 02:10:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint; bh=iYNXO1UOt2AEMEXnjFa3s+ZmwY+51p0DdnQfLLFwOow=; b=I
        21BMteLKs/Aj/T48QVGzUt/P8wunLghMdP8OxsSLLyDrPhTRf5g/maWQJPJMCBKE
        3qE6B/d6QdCLToQF3zH6K/rlQHBHRhLbRPHDOwngoC+pltFreax2MqQExHfARVTk
        qjcRlPCPcb4QCP0rYz4njBY+wqtbAHQ0Kh+MrcqDwrrggfoHJpOhkAFCMKFTzEpQ
        38do3fdO8edxkhIJetv5863OBDTEU5vS3+Blqv8L+UQTRLb0qAD89VyiVRbm1qgK
        WSjbH9Y+ml4gI/RgSh3EhR+ojH7s+td3hWAm0cDleLAVJBV8PjHfHAI/y6cbCDkq
        kb+6Pq0AxeCy8ou+QGIiw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3sfnffu2r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 02:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM/qknEGDKRdo1ua/BjUAl5ugYj/ErnyOZrzxicitlXh+ED044pbRDhJvOmosUSIBmdj19FQ7+uB+mnsfo5k5P0TG1+NasbWngIc64srjm5ggeWdt/j7KsgLoAz71eZYPB1wWkHzWNDlZw7y+BYaeQjWBKQ6IclZplbKta/4UZWhAH1aLk0sBDd/arrrJzr/jYfRB/Eu/ZQ5kWQcbOxp1m3fMIFXVDsbJrJkx1nIf6snR3Ju4kV7qWVVVgYsuXEU7bWniV5fZyyvao/+l5h7wG179zRBi0aKrWI3TLfybBkUr8H9Z69O8uDOJO0pyQjN6Pvq6bRAkQuBDB85Vt5jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYNXO1UOt2AEMEXnjFa3s+ZmwY+51p0DdnQfLLFwOow=;
 b=b1AWAqVRU8l367yNPySa+znbSNzF+evlNep22OYOfhdMPyXnOOU1pen1bRvKQoIzBC2DRS9GpcvD7Ti494a8zRBIyfMYQXOIlfSKU1C9F5LDGMg3TGOLaOuYBFcC3PMZjZUTQ0FsgqkyLnpNkcd3I1BNNaT8dJarDbBWuR3alTS/IVfecUnYHUivWVC2qKaTCb2adhONV3iMbviK8dDu0NPh0UQV9PR4eAugkcaCFUMhOixVs94v9UUt5VMqMmXYhMa2g+oUNQ3sFgsbbVqviP7x6Ut6ZCy+IapP7lPgxP1W6EvMdiG3a09Zaft0I2auM2rq5agqk9o20QhSYIuu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYNXO1UOt2AEMEXnjFa3s+ZmwY+51p0DdnQfLLFwOow=;
 b=aRrzgFicWuzHqc0RxpzgSiYqGpXR86oFB37h26sr9Z3QKDhUzt+yQj/NHC1rglw2wXY+ttQTY3omMuWO/Ge+GFQc5Q8qLCX8nNHnKOIp2CJrSetvpjq91TFyHXfAdKsBOQhioTgnM+nASWr0lYq3PfUzOszQQinW6gYdGQXgrNQ=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by DS7PR07MB8352.namprd07.prod.outlook.com (2603:10b6:5:3a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:10:34 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::571d:f5d4:a9a4:dbb0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::571d:f5d4:a9a4:dbb0%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 09:10:34 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued
 requests
Thread-Topic: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued
 requests
Thread-Index: AQHZtWIUOnzlmDC91EyICLRPIn7cGq+4hxoAgABUPOCAA3K6gIAyDw7Q
Date:   Thu, 17 Aug 2023 09:10:33 +0000
Message-ID: <BYAPR07MB5381A0D4D62053442E34B275DD1AA@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230713081429.326660-1-pawell@cadence.com>
 <20230714021436.GA2520702@nchen-desktop>
 <BYAPR07MB5381BA3F7A34D18BC16B86DFDD34A@BYAPR07MB5381.namprd07.prod.outlook.com>
 <20230716115529.GA2529084@nchen-desktop>
In-Reply-To: <20230716115529.GA2529084@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTk5ZjczNDEtM2NkZC0xMWVlLWE4NzQtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XGU5OWY3MzQyLTNjZGQtMTFlZS1hODc0LTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iMTg0NyIgdD0iMTMzMzY3MzcwMzEwMzAwMjU4IiBoPSJsNldzQ0Z2eURGTC9iZFZ2WW0wWjZCUUNDZXM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|DS7PR07MB8352:EE_
x-ms-office365-filtering-correlation-id: 2eccfc2e-5b8f-45fc-64ef-08db9f01cff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAb78dbMAj5Zn3SaxVxAJn9+1xz/VPZjBaS2TM9JfF16Kh3c/0XmDMVaRPcZ5VOY2/P+UqSCnWc7Rt0AoMtZ3+DjLhNx8SMrbbjijl+OoWBgJudy7tSPL4s51lASMlJEO+Y50WKQ7uYV0lPDZPUFw30DIlJ54UoqkRmPeGX14RTvA/lQXmGL/mVOIsOtO91sCVxSkLQmyIgkWFzyFmkZVv9YIw0qkbKrLSl3Ud81iuHsX0lYWWEzHZvYEt2bBiGMuqMSLysCqPEGO2RN/GPdw3IC5ANhDxZ3gjVcSIaAFmR6ST9zx6ba60UgWOAJr/Ty5DZocvNgYFyI1S5EyibNT+Kh9xHXch6mwQqb0AqdGt4aBxrAkrmAqte3vU0GJLwccaZIujijgGnxTNrzkt98p1D1z6Y3XzDJrW7TRtQ8b3EEYf9dBoW/E9sXU8q/g9lcAM2JFItou2oM1L6aFAQoqhb8Fe1kp3wmxaC0OHsWEcNpiBSiEVKlN57bwvIQhlujGT0LQBB/AoB6kcATZBwqr35JhLurSxc+uqpCZdEEzRIcHotmBzcC0ErkQExjDw0tl3P4nfMUh8wfLsOZtpErlq/YxsVVTJkraN21V6OuvMEqZR2eTuw/Yzo/egoFzI2P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199024)(1800799009)(186009)(86362001)(33656002)(38070700005)(38100700002)(122000001)(55016003)(52536014)(5660300002)(66946007)(66446008)(66476007)(66556008)(478600001)(76116006)(6916009)(316002)(64756008)(6506007)(7696005)(71200400001)(54906003)(26005)(9686003)(41300700001)(4326008)(8936002)(8676002)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gVhOuB0N5EZWf0k8NRujkrDA7y1g3pBtCxZQfnZ2R0R5qEAglDS20yUi6iXn?=
 =?us-ascii?Q?knlOi4LQn8QGEp/LB2M/I4O2v9cgd46G6goM5yQIg9dOQZsC8V6/jTabQpVD?=
 =?us-ascii?Q?TGiKjSumwz3Zfx9218pcw3uSsXbsfTrlINpfaW5v6ucEqRYGSB7Y7D4UJ6yt?=
 =?us-ascii?Q?L1+Ft7S76LXuMUm+tCPIu40puP4uDd1g4WKxvM0xYWy6q5/SsO6tMfaYR9mX?=
 =?us-ascii?Q?2kM9ST3tnVEyysjYWzkbA5X9whGjQuwqEp1imsWVCtXr9hBJeJey7RQw8GGc?=
 =?us-ascii?Q?qGda16FFIyk5KMN9o8dKNpH6nEvOgOX5Sbq3hlMHT7GzLLkEtgHg3TqkzcE/?=
 =?us-ascii?Q?8yv839Bo9Jbgzq210XFaUETH57f3w6BK4P6HqhjaEno+q+alB2PFJv9lxElh?=
 =?us-ascii?Q?SuuRqQdXPrO9yV0rCVimA2JbQsoyIf/NG+qytiD5VZttbu8Qj0sWl4SHEYo9?=
 =?us-ascii?Q?sxia81Q/pnDVRUpK64MoVG9AUz5tux+n/uvYJZIPPgeBLh9rneVdghhY0kK7?=
 =?us-ascii?Q?vS+UgUO46QKPsA7cqivqpIjzI1O82Doay5cYocau0Y907X7E3ArxNIsr/Ccz?=
 =?us-ascii?Q?sVpke/bnl7/U5h02nUMyftqPYYqfE1XaBTm19wNLsOW2GmDxffqmaRKTm1r4?=
 =?us-ascii?Q?VBptQQ+LJcmCDvbO3ZckMuocIhHCrKujONIi2zjieCfO7PtJw4TDlLDcjOB2?=
 =?us-ascii?Q?fDv2DGRJJDNbXZJCtLQiKGDiRnkTEHAzA8Z6nNUOQP4E3w9ajD+cr31vYxCl?=
 =?us-ascii?Q?E910Tt1MmCNJQvbbq3xOa4v0XOhRmYjjIr70XfQM4ZJPRe0BMOYZrw83U2JK?=
 =?us-ascii?Q?PdsMHBOCu5n1RrrZM3T7jE74gCrSZjS/wax4vq7EaRXH5zMs+wT2YkhwWvaU?=
 =?us-ascii?Q?Fcc4ISMB3BZPe4aSlVDJNOSxmzJ1xtAiELEmAfJEio6K/ujwbsVg4vx0QFEF?=
 =?us-ascii?Q?kE6YguNL3zVPnTGSDbkfbefXD7TxshlpHTqsEMGXhxFxBoFzA8Mp19GZ2JOQ?=
 =?us-ascii?Q?2lfSeBZP8K1LdITnOadOOzyG1D8Wq+5R2gwDV9dXGA4KaJRz1X594rpM7SR6?=
 =?us-ascii?Q?MaHLafT6ahMVhynOZ+kRwMQzzIcgB4P24ePjBdc0GPfPrFI1MyHVHfOXWVSK?=
 =?us-ascii?Q?ZBLAp0WYki9kGWJppDQOm9p4f7q2eq/cNlOS8P1Aka6gB+DTuW+OojQWkI4D?=
 =?us-ascii?Q?AQzRpC83Nm/tiIJdzKQ1p8Kz9rG3z2BIqVekANjalGgjZxSLDGoW0xBa0k86?=
 =?us-ascii?Q?ZyquF2P9sP5/dJH1FHvjHaDozpnnpSX8SxQfFmUudRsSezcCoF2WY0SBX1r2?=
 =?us-ascii?Q?oLBUqyWO4OXps6Mga9f0KP0VGIdJosj/d3UqxYgKBnL4xZyzriZOrziyZYOW?=
 =?us-ascii?Q?kfd+GCSFgSNebqstBc0U7MUV/+Io9EJmFdXBRy9JptwFFTQu3fiQUBmHPzja?=
 =?us-ascii?Q?NHXLqhwvv96mv6zZ/xS5cnzgt7++SKewOWiqeJPhN5BTGq1oiZ5X0PMxj1xL?=
 =?us-ascii?Q?I1Nly76r7WXtDDZczoAyEemhiL38+VoB2+ogHXURNzDndn1JDiNxgKogeV7x?=
 =?us-ascii?Q?mBmHHJ3u+JEo44pOUaMkFEIcqb5lQ85OK4+RgKwE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eccfc2e-5b8f-45fc-64ef-08db9f01cff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 09:10:33.5243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZY2LntQCArVHNw1lZR6S1Rj5vb7FT31XyAHvSiqD5taiainA7b08Tx/o+j1tOBbCI0bqatVUT532oa0fjn/JKTwWNXXK/RdkUdekIqWNPQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB8352
X-Proofpoint-GUID: vMm3du8KjkHcnm7JkRoPGBWf5wycpnU0
X-Proofpoint-ORIG-GUID: vMm3du8KjkHcnm7JkRoPGBWf5wycpnU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=730 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308170082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> >
>> >On 23-07-13 04:14:29, Pawel Laszczak wrote:
>> >> Gadget ACM while unloading module try to dequeue not queued usb
>> >> request which causes the kernel to crash.
>> >> Patch adds extra condition to check whether usb request is
>> >> processed by CDNSP driver.
>> >>
>> >
>> >Why ACM does that?
>
>Would you please explain which situation triggers it?

The sequence to trigger is simple:
- Load modules (u_serial, f_acm and udc driver)
- unload module

In my case the plug is attached to host.

While unloading in the gs_console_disconnect function is involved
which try dequeue the usb_request not queued.

Without fix controller driver during dequeuing trees to make operation
on not initialized field which causes the kernel to crash.

Regards,
Pawel

>> >
>> >> cc: <stable@vger.kernel.org>
>> >> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> >> USBSSP DRD Driver")
>> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> >> ---
>> >>  drivers/usb/cdns3/cdnsp-gadget.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>
>> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>> >> b/drivers/usb/cdns3/cdnsp-gadget.c
>> >> index fff9ec9c391f..3a30c2af0c00 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> >> @@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct
>> >usb_ep *ep,
>> >>  	unsigned long flags;
>> >>  	int ret;
>> >>
>> >> +	if (request->status !=3D -EINPROGRESS)
>> >> +		return 0;
>> >> +
>> >
>> >Why not you use pending list which used at cdnsp_ep_enqueue to do this?
>>
>> It's just simpler and faster way - no other reasons.
>
>Okay, get it.
>
>--
>
>Thanks,
>Peter Chen
