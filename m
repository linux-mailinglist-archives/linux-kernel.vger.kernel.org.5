Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105AF7D5FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJYCZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYCZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:25:29 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82499C;
        Tue, 24 Oct 2023 19:25:26 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39P1sEUd024298;
        Wed, 25 Oct 2023 02:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=jkmYaKf/hvpnwlNMd1NL7PJsJcTT1a1Mj/0lP3RFx0w=; b=
        YmaR1WkWki7OSVh8AXoaF96WSLEQRT46C0T1nFNaAyme1hlx4hbAT3BXamqOA3iE
        y/8uUSGSlCDao11cyz17eMavnUDuAKu30Ti+MOWISRHEwXihFrwbjI9Rv3mZz+Hx
        7h15EuQun6DzpiEmf9hIl9AfTBK4XiItcZsWMqRYNEmk6BUgjhHHYSE+eMIBg/Ts
        1iuxKJg89peAo0cFXo6VZfdpeKFTe0RxwVZ1fIDQw/pPr3oOOJ1rhQo6kjNFBj0A
        3wwzdlzL6ejwNNe+Brqoq6CPvhHDJSNEWf+td4x/IIWAWGy3N+4Iz3TFeljlts3m
        Xa0gh6m8Y5fjUTij5UKdAA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv5m5v138-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 02:25:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY40kbZQXS+/MzwmqW2Qx3ShSo+qtY5doL8NlPnRk9kzy0Yu7aNvG9hiDaum5G/S3XyW9okP0QwQYSWt1pqOr8VhqsIF4cZUVnWFi3raOr/1QSTAJfMciF+cZ1VbK5D4UjqKjqoPYG5wkEfugLPQ5it3BiN8JYV4Q4G55ZbL+kDevEoNALjDsvsycT1S731Ia8Pt868cU59TNq2tSQHWxY9hr/ysDHmb44KyceHlQnAGggc4sZ35LLByN2FwovpJCFiH+F0UQHjSC+KwNekNT6oDiRQe3nxy00Xr8XvRFyY1/a8K2VtHupzXf+staxJQ/QkoDhvHDTlGJuNfq1anbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkmYaKf/hvpnwlNMd1NL7PJsJcTT1a1Mj/0lP3RFx0w=;
 b=cnfR2kCupqjkT6cP3XMNM8BvtW9VnO7d/IFTiHZc1TIxEUwX26JDSPxPKAN8rJZhtkFDWZVWy1X6kZADinzfQTE1z9dPTFBQ1Zaj9BURnJHOh7M9SinoMwUMApv2y3izgYEthOGgahgURNyY4faLjaf8nKyI40/fuIXT/PyaQWsVlYiXLGyzn/SNmwy+KADFyJCMf6MK8uQXU3t0sk0d/CMkEOzhOv1ZB+xoSLkgA7xE909vqWL8lsXIrWduW3zF8VgRM1YNqeMwy0zk+VrD5Sx1eyGw4N4pe/ImPNaZk6bcE+SKLg3ZwFdDbDg8Raq3ZW9IeqJyQXaN1as8mlWXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16)
 by SA3PR11MB8117.namprd11.prod.outlook.com (2603:10b6:806:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Wed, 25 Oct
 2023 02:25:18 +0000
Received: from CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::37fc:5e18:cb39:ca1e]) by CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::37fc:5e18:cb39:ca1e%3]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 02:25:17 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: storage: add shutdown function for usb storage
 driver
Thread-Topic: [PATCH] usb: storage: add shutdown function for usb storage
 driver
Thread-Index: AQHaBXOS0TY0dBbnMkyFvU8OyrUaFrBXvqSAgAB6/iCAANrZgIAAAuUAgAADnoCAABRegIAAJNiAgABwKrA=
Date:   Wed, 25 Oct 2023 02:25:17 +0000
Message-ID: <CO1PR11MB5188998FE62B30C3CA83A6F8F1DEA@CO1PR11MB5188.namprd11.prod.outlook.com>
References: <20231023054111.2744872-1-Meng.Li@windriver.com>
 <33bd0779-bfe7-4c87-8fe6-ea8455df3b6b@rowland.harvard.edu>
 <PH0PR11MB51918DD50651DB6BE937BEA3F1DFA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <3fe5b43c-a5aa-4c6a-8614-03a4d9dd53e2@rowland.harvard.edu>
 <2023102428-zit-quickness-9b73@gregkh>
 <5107f6ca-e972-4af1-a21d-6c95778969f3@rowland.harvard.edu>
 <2023102459-protector-frequency-1033@gregkh>
 <a6bb88cd-0b89-4eb1-b90d-8ad633b7a8f2@rowland.harvard.edu>
In-Reply-To: <a6bb88cd-0b89-4eb1-b90d-8ad633b7a8f2@rowland.harvard.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5188:EE_|SA3PR11MB8117:EE_
x-ms-office365-filtering-correlation-id: 16eb95df-4532-4fbe-a8ae-08dbd501a129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zd4gzyCbK/XrkKrjztTzAFsMWqRJvA354G/1kBFlxVW4B88gdekFPsSJ0e9uWtfFcdkPQremjOoqiLr1u+GGuUn6ndB3yzncc2e7be6U18p7BPP/1G37ITQGTBe5IdzMHWb384Z14PWz1ZDVyzFIw7HJXd7yVoLqS1O+lMCGOw5EW9qppDuK6a7gipJBHJU1K5wj4XzQolS6xVkesBJXCxZQgVSwL38it78J+Zqxr2oFWb22DG971KNC7maCBlL7X8HtBBdqf4xZVsOBHXfkFxRpsa1/Soh9koSus65qpRiy7iVRg0TjD5ImLePIRgMed/JSlil1VeFMKRsiNgH9mbzKvTduNKP6V+0JpI11N2VsWEuHvYT3MItiFHnEfNxDvb8oFTNSk4FL35KhkK2gqoObJkIk5EI5woIE8GnG8X2Gd05orVpPPAim6RR9+MMxG/9Jsi7nVRR6z43zitTgemMIJe9vzuUxiNzDQWcLXZ2V5gXPCiB7LZsdrWlHIZMEqGSp5JMr0Sr/X2nnVZYcEyU16vQnJ0MrhRJUtNCFQ6r8lmuQVZoxoOtk/FcqKxUWvfj4EIr3hFWDNT5KyXjwWOUxjMSHKTG+aX3rVyH1HIahXxasFsvUUpsHZ1Py79VE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5188.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(53546011)(2906002)(478600001)(54906003)(71200400001)(76116006)(6506007)(66446008)(33656002)(41300700001)(66556008)(64756008)(9686003)(66476007)(86362001)(316002)(26005)(38100700002)(7696005)(122000001)(8676002)(110136005)(55016003)(4326008)(8936002)(52536014)(5660300002)(83380400001)(66946007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q/L7f77OLi1XGHMw0rv/kpdSNp/ZFUeeJqoxc/JQy1G0YpanmV4AcAbtRzmj?=
 =?us-ascii?Q?bWNEiGh1gg5qx/ivpDMkxGpaCfKBxMVt31CxJqRw1w+8ZB53zybkP9ItMbI1?=
 =?us-ascii?Q?fEMpfQTgeIi2rPiPYPC63D0+sqhUc6pMRBl3Zms8j++afyg6oDAbPDli+m9/?=
 =?us-ascii?Q?1ugwEontEzRhCVOsPSMFkg6vyAg0+FQWZtb20EQ8Wys6qCES9Q2TowwVxDur?=
 =?us-ascii?Q?febu7WTlYjxiDffBIKVRi0EvHhiwuORmEvwI0f3KAdGy+d0/63YlaFYxKTl3?=
 =?us-ascii?Q?sBkSfU4b0yjG4NJY+3qN73YWWrCKqB6d+Xnmns01E2Rvagn7VG/KN9cjLfpF?=
 =?us-ascii?Q?RR8Qld2fmjR0/BZUFJ+FzE72q6OahranUKzYevpo1S3o7xtvv4cU/9afWmPC?=
 =?us-ascii?Q?sBX7JSfeYBslTxLOfR8R3KwgbIKLZPI+9PMxVGlKmKG6zTfOJWgpjVy3Attq?=
 =?us-ascii?Q?uI908KdPUdfNbKYURJB5Q6wQWgqBGIF8JIZaRhBax7vJqCQJpnJKzVNSm20E?=
 =?us-ascii?Q?Vkslz0Ld4nToNw+4gpxzfNxWEu2ZBTLmezxZEuWw33Bx7c5AX285bLJDNsiS?=
 =?us-ascii?Q?oU9lFYOvlPQMYyk02599E3wjjyfp+1oV8i0fmXijVNfrKnofNmH6HZfZg3Ez?=
 =?us-ascii?Q?IFh6uBsL6tOMBGbEOolm5BDwgNd3PDpEI7anNkyLtO7UdqZH7lgJX33KXM+j?=
 =?us-ascii?Q?k5bHAOFV5QpOsHwFHvHBOEelxQ+BDC/boNql4WftDYoo2piFArVkI+n+G7UW?=
 =?us-ascii?Q?uFiQZ38otmuFGwbdRXu9jribXrXWd0fn3ormv00iOHq7dTZ9/qiSUDs6R9Hs?=
 =?us-ascii?Q?zX1W/BNUgbocPz5bt29FzVE7k0azlrE5246nRXqVP54CAH8WnmsFik/T19sC?=
 =?us-ascii?Q?OJYZKizMRd3G787nXXmDRIsA9rm2LIbc9n/7BfN/ISeeKWf82H5L22Wbnxsx?=
 =?us-ascii?Q?Dtz4rMQJJ+Z0AlOBLHtLAR8pmTKO6goctnBj/C9dEbqPJeQbhyRtpwCfGtQU?=
 =?us-ascii?Q?5NwO5qXwvFhye/SZG2JcQiNh/HHtaSa3FVDPl8QaTIft663gPSeXJIUEHddz?=
 =?us-ascii?Q?+7kHxcg686I9H3wERSrWnai0ObcIUpZEPMEiDaPLhkeCl2uIYeH4wqfRdaBY?=
 =?us-ascii?Q?wJuqRR1rX2kTcHm0vGiE8NNsnz+e/nXeWSigJEpdAGDnDcTE0qzcWTooYniM?=
 =?us-ascii?Q?8obdOTG78ZNH2s9+T3aCsfrWxr2ObpEhVRwi9fFwXOsrUszEtl0nqDaXhGoF?=
 =?us-ascii?Q?GyKJoqrqgJdFjT+hgUvAeg89nvLB7uwlyH3yF1zdLU3z5ybZ5Qs8u1U6d3Sv?=
 =?us-ascii?Q?faysqseDy3Uwzp1/eXi/dZ9HgYD5qqQzo2Fhs/SwaT+bNUHCq+l9pVZavErR?=
 =?us-ascii?Q?+hoxvlKyfYRIl4MqG92yRhPf+VIqJRgpgIjWwfRIUzZ8VwxXkaI4WHgsq9KP?=
 =?us-ascii?Q?wP6811gRR+HBVvg/4qkAGMCnHviKmWw7uVaRzUd3Ve5R+ZCFGHKt/ddcAdrF?=
 =?us-ascii?Q?Exu995ktV1+GPW9BOUJNu1WVS2eAq1xupFb22Ju/nhCBZLmgcDcdmjpzyJkD?=
 =?us-ascii?Q?PU8LhAhDfUQIPw14z24d6L0PM1vVTA2fULKkLgt3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5188.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eb95df-4532-4fbe-a8ae-08dbd501a129
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 02:25:17.8199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kor143Bs4GDoN22Ps1quJQtgqFhYVWOp9RdgwGL/q1HVoTLnrM47cnAOJjnY2TKt4jAUz+LGE/qSdZpoldPLPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8117
X-Proofpoint-GUID: ydie7U6U-GsM_b6XqYPqNXiszHCC_o2Z
X-Proofpoint-ORIG-GUID: ydie7U6U-GsM_b6XqYPqNXiszHCC_o2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310250018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Wednesday, October 25, 2023 3:23 AM
> To: gregkh@linuxfoundation.org
> Cc: Li, Meng <Meng.Li@windriver.com>; linux-usb@vger.kernel.org; usb-
> storage@lists.one-eyed-alien.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] usb: storage: add shutdown function for usb storage
> driver
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Tue, Oct 24, 2023 at 07:11:31PM +0200, gregkh@linuxfoundation.org
> wrote:
> > On Tue, Oct 24, 2023 at 11:58:37AM -0400, Alan Stern wrote:
> > > On Tue, Oct 24, 2023 at 05:45:40PM +0200, gregkh@linuxfoundation.org
> wrote:
> > > > On Tue, Oct 24, 2023 at 11:35:19AM -0400, Alan Stern wrote:
> > > > > Okay, that's a different matter.  In fact, I don't know what is
> > > > > supposed to happen during a clean reboot.
> > > >
> > > > Define "clean" :)
> > >
> > > In this case, I mean what happens when you give the "reboot" command.
> >
> > That's a userspace binary/script/whatever that can do loads of
> > different things not involving the kernel, so it all depends on the
> > user's system as to what will happen here.
> >
> > Many "good" userspace implementation of reboot will go and sync and
> > unmount all mounted disks in the correct order, before the kernel is
> > told to reboot.
>=20
> Even if the filesystems are unmounted, the kernel will still probe the dr=
ive
> periodically (once every few seconds) if it claims to have removable medi=
a.
> Failure of those probes won't hurt anything, but it is likely to generate=
 an error
> message.  I don't know if that's what's happening in this case, though.
>=20
> > All we can do in the kernel is act on the reboot system call.
> >
> > So perhaps the original poster here can see why his userspace isn't
> > correctly shutting down their storage devices?
>=20
> Meng, can you do this?  Maybe you can fix the problem by adding a script =
to
> be executed by the "reboot" command.  If the script writes to the "remove=
"
> attribute file in the drive's sysfs directory, that will unbind usb-stora=
ge from
> the device.  It should give the same result as your patch, for clean rebo=
ots.  It
> won't help "reboot -f", though.
>=20

Ok! Got it.
In fact, the reported error is not critical one. In my real work environmen=
t, there is not the error because there is not PCIe-TO-USB card installed o=
n board.
The issue is reported to me from our tester who used the PCIe-TO-USB card t=
o test the PCIe feature, not test USB feature.
I am ok to NAK this patch. The primary intention of sending this patch is t=
o raise up the discussion about whether shutdown function should be added f=
or usb mass storage driver, and I have got what I want.

Thanks,
Limeng

> > > > > What happens with non-USB disk drives?  Or other removable device=
s?
> > > >
> > > > It would have to come from "above" in the device tree, so does the
> > > > PCI or platform bus say that they should be shut down and their
> > > > child devices?
> > >
> > > Well, the PCI layer invokes the HCD's ->shutdown callback.  But the
> > > usb-storage driver and usbcore don't know this has happened, so they
> > > start logging errors because they are suddenly unable to communicate
> > > with a USB drive.  Meng Li is unhappy about these error messages.
> > >
> > > Adding a shutdown callback of sorts to usb-storage allows the driver
> > > to know that it shouldn't communicate with the drive any more, which
> > > prevents the error message from appearing.  That's what this patch do=
es.
> > >
> > > But that's all it does.  Basically it creates a layering violation
> > > just to prevent some error messages from showing up in the system
> > > log during a shutdown or reboot.  The question is whether we want to
> > > do this at all, and if we do, shouldn't it be handled at the usbcore
> > > level rather than just within usb-storage?
> >
> > We should do this within the usb core if we care about it, but why did
> > the USB device suddenly go away before the USB storage driver was told
> > about it?  That feels like something else is pulling the power on the
> > device that is out-of-band here.
>=20
> The device went away because the HCD shut down the host controller,
> thereby stopping all USB communication.  The usb-storage driver wasn't
> informed because this all happened inside the HCD's PCI ->shutdown callba=
ck.
> HCD shutdown doesn't do anything to the USB bus -- in particular, it does=
n't
> remove the root hub or anything else -- it just turns off the host contro=
ller.
>=20
> Since USB class-device drivers don't have ->shutdown callbacks (there is =
no
> shutdown() method in struct usb_driver), they don't know what's going on
> while a shutdown or reboot is in progress.  All they see is a bunch of er=
rors.
>=20
> Alan Stern
