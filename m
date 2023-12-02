Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9065E801A9E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjLBEWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBEWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:22:51 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74CFD40;
        Fri,  1 Dec 2023 20:22:57 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B24G2Rc007261;
        Fri, 1 Dec 2023 20:22:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=lNhBeuEsg2n4sw/z3enaY5QiUGO1uKZScLpDFbBR3RM=; b=
        r3+6FNo1Kwh1V1e4R+p7LJjlpwlRVnQyHV5NOYKGtfrMj2Jm9qwaYvzzCSj0+tmG
        1CjFvXgPbMhbHQWifkrQ8qAt7BziWWn71N61Tync7QW0+RHwIei3OwE8gDLe2RYU
        lFL1D2HNyoeG6B3h+cSKx3WzngfbHhBLLIDOEOecRYUP4GmQbPwksv5+Jpi5CjmW
        mX0QaxcJ87nBUMngBgpMYyL+sVvYaRFFbxix7BomO6JZ7K0yNswiZ43XdYaorH/w
        apVEYdeAqPMnc6Hq0/bBDDMnkPn1P0atuycsBBwl93nvlJI/mCLiVDnr9lZpiHhS
        AM1ncVJDIR6HfQ4rd+sT+w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3upgxtjd91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 20:22:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osq1muF97xuqyQn8PPj/PefGVDwZtEaT6+864yZTU5rbCu4Z73r9CGUZebnz5sEZjP9iZXy2K7XVqTRr0Y9BTuyopQvI6WXKfD/+UyBkRjnYODBmXFYwI9Aojj6qCYxA3lH8vNVzxICKuVI11LxLsYgalSNrX4D/6L++iPC+i6k/Pr7YX9GvFEtx0YDH9WHm8Ly31mWZUzDXJnrALqzKWTqxl1tqIXna8BHoKmk9U7ZSeis1uPPUnmRbmI8v9Lu4j/IsaRnuIwOgbdSHZg+1ySNoPBA/58P/xYuMGizBZ1JymFfWeX2MZKsTycC3IFnbM5725VGUti642f4X1Y2Mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNhBeuEsg2n4sw/z3enaY5QiUGO1uKZScLpDFbBR3RM=;
 b=OJG9KrYqDWimMH5udZ/0GwY00POHIVSFV9dCz94TwXpRFUbf65raJePo1uPiDUuXEHb3roXXEzTx0t2HwhvfVpSIA6gmxS9u3U1OCYr7v30yQgvWmJzfY2bLnjFgGMU7zcsDhzvdhPuztDh7ua5H7nXjvcl9ehj1Fo7e3jDSjzvSaujwRLDRsiETM2xluRvRidrn3AMQIIERnUyRbTwq1wg1VjdzqhnChmwOA+xv12JYjB0DFhDQgCBl2/sNJCEPB4h5VZTDx8Kff1D3MS74xWo4q6x5OklSzxbj9Ch+9xtQOXG7o66/Z6OYrTmK2nO8vIC0Ybzzl92GmUQxO+7PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 04:22:07 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%5]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 04:22:07 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Kees Cook <keescook@chromium.org>,
        "sxwjean@me.com" <sxwjean@me.com>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] mm/slub: correct the default value of
 slub_min_objects in doc
Thread-Topic: [PATCH 3/3] mm/slub: correct the default value of
 slub_min_objects in doc
Thread-Index: AQHaJAS+/5op7CiQkUS+Ok/d0deY+7CUtZsAgACwY+A=
Date:   Sat, 2 Dec 2023 04:22:06 +0000
Message-ID: <PH0PR11MB5192C83167C9A7C033B1DCA5EC80A@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231201031505.286117-1-sxwjean@me.com>
 <20231201031505.286117-4-sxwjean@me.com> <202312010948.63ACCAAE@keescook>
In-Reply-To: <202312010948.63ACCAAE@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|PH7PR11MB6522:EE_
x-ms-office365-filtering-correlation-id: 8f73647b-1991-42e5-01ce-08dbf2ee3e5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXUGk3POKBUKaPnBBnC9pTWBoklVo+bLqLWjeXV2zxDx9HzmpkRcEZmPSMeXT/6w7bjuZgmqKt7o0Xg6txxdKVfT66ZtG0APeb5AWKwCaCHhBTEFytB+t4QtSfuhbUwm2Fi7h8TLOrDmHhXz/aKOwjHylTbyqJK9sPDEKpZWUnwtGE1sHlz2fgrHID9RTPd3WNy0RTzKHQp+DFTeuUwrWVyEXB3b2DMGE5/sB8naE3CQzU6ddOJO3dnNsy/1KCbftzwtGkNLMl/+i0bwhvIJlrZWaCyQ95dTrVPKLm9goJzuAgr2y3aByySB5qq9QlHM8v1dynX013PYTdmsMLWZ3bl+kuFNHbEyDwUG17ocDUffi5ZuiSK9chhPxade4XYEQTTNKNL5ky3+VKDynzymWYawlK1ZeT+0n5znY8mBwlJ2QNe4w8OUb83EcJNyw1itzQw8hl3LXIbcCe9mGXvoRMlCVhXNd7LpUFqtwtVd04i7urgjOTQkraa8n3HyWQsnyKjBXU7w+NUQ2idimf0oh0OT4Bfa5B1c51cwL/TN5vw2MQ9lDT070dnT5EIWZiwS2uEFYj3bSdtgDs3WlB+Bf8yG9almCEvK2aIBUz1PK74FBPpFT3JwSLAF6rN1op/vY0TwT7etJtcQBzTa4ijGE1t736HVxfZcGwsIXurpd7M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(55016003)(5660300002)(33656002)(122000001)(86362001)(7416002)(2906002)(53546011)(83380400001)(71200400001)(7696005)(38100700002)(9686003)(6506007)(76116006)(110136005)(478600001)(41300700001)(66446008)(64756008)(54906003)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(66899024)(52536014)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Alv7palcybKos6O3Kilnjp/R8iKUc+LX95J+jmVeHZq4p2BfJYLtXjcYj+b?=
 =?us-ascii?Q?LEIYcuzWf+kxXc9lHZmlY60Ft6Bs4xAy/Nul9mcXAMctZuYY1VTQgpt2cKMB?=
 =?us-ascii?Q?y+HIFW/phDz+Ta1qaVE+5xed9i6x8+OirLx1vKVEgpsY3fqMiuuuzocQskkc?=
 =?us-ascii?Q?J5MDXCxauYV68+QWP3s7hCgvwDjOj58FKmmZS30tQineMyoDu06J+VZ8OHFv?=
 =?us-ascii?Q?sJaZ6PIsvPjQiXOOTc+jXizXDOMc6qpQEuGaSnzrR8v4DKNDiI2ib37/1AWV?=
 =?us-ascii?Q?3l54N6e46oj5uZP5KcbWcJXNx8MNEZ+KrYQ9a5rPKvu0ZDY9/hiTN5qhM0/O?=
 =?us-ascii?Q?n5aowJMDmtQH035FPYIXgyrJPe3C2nZuXC4P/6LdXuUtaIUrLI2Y7eGjVymC?=
 =?us-ascii?Q?bcUrndQPhX0YT8HgPMBimva0pfdi62oER5ovWn+4XhGedW3pR1VYeugPjqzw?=
 =?us-ascii?Q?bm6SAVHcl4sHI+g9+OhxfVCs5dq0Ezu3j5czd9jaLVmcYwTKKvjnxSwGp89o?=
 =?us-ascii?Q?F7F7Vcd+brylgIeeIsSS7VJU+Kyy3EKM+/Bxsn0Mo4uffG7l7PC8MqY6Ddf3?=
 =?us-ascii?Q?LvbwGJnegTM/twbzQDXRyqSnEvVpuAfsF74ZvMAWCZvpzNUr5uX0OvPJ6MrC?=
 =?us-ascii?Q?nMMP6knMLOqa7zIKTGTY29ifUT9NwYkjmSpPfTf9LswXJC4Gh3VeejUlvNK4?=
 =?us-ascii?Q?9yil4hdvWS1M51UEOOiv4kDz7zHBXJymW/+Q/csmnAdPztriUegQWpDcylMK?=
 =?us-ascii?Q?TYBMS2qT63czL/PbATNcsyg2a1M8d7+dvfzVOUuwoHSQT5spdlEGOySpIWil?=
 =?us-ascii?Q?36Vm+pXmdPsAnqJsghBGWDsuEkweGdj9eGrQv9EauJbNzl4jd46EShrOqrWr?=
 =?us-ascii?Q?UmkC6YmFDXiXDJDza/QqMVwaCeYLZ0Cpdbrbg4zHVIL4Hj4HGjwLXBpwmo9V?=
 =?us-ascii?Q?tvklCSyXbhPu1xchCJPYlQRxvt+PIBDAsCtxtHu2TS929ANpd6wuh/Ly2u5y?=
 =?us-ascii?Q?jMmUZ1xFIJH35hHCMiDj0bgc+5FVV+xhp16+Xp1QUDfdBBiG2PVuLWQALJ6Z?=
 =?us-ascii?Q?DQwDm1HMWgn8NR0XdV5Zv+xoXvN0fuWDLPSR98yIhjgGi6gLDOgkVgcuhS9x?=
 =?us-ascii?Q?GQpblcHp6CV9Sm1EodZjrUumbtDOfmGxOZCyxMbdOk7EdgoUksY/3Gppqebm?=
 =?us-ascii?Q?d/nleDZTo46FcTz0X7rbCy175E5TKoTvJBNuj5pQ8M2nJk04qHxPFztauNzs?=
 =?us-ascii?Q?tq0Er3O3aj+ozRTc2HOcupc6XSJMeiYu67OHxK7sCSKCHVXDT1lUqkuLi0a2?=
 =?us-ascii?Q?BA++pF+wStVvhuIG0v+gwtv5M9RY77hXX7i9FM/77+ajrwxJyOEleGvVLIUZ?=
 =?us-ascii?Q?lfmpr/yrqwsBzEdYxFfBOOjYQeR/Xu1gvRCZ+grWC2wt3wQ1DqxJoXHzqCmY?=
 =?us-ascii?Q?ElmMURGXusoHFs6Oh7CHV+m9/gx8PNCIe3sI6ZOTOzd2oZuY+zzP9j3ynZes?=
 =?us-ascii?Q?Xilxg9O+bBUDnJ7JX+h5ZksnJ32HSzoRgDoAtl1Y/PDBrqJCTDZBW3StnmxZ?=
 =?us-ascii?Q?x1204pWlJTQ0I1hkt2Lq9fE3Bhtg8RUhhk2kLQ0W8DjLp+fEMI+MM9vLkSlx?=
 =?us-ascii?Q?/MC9lTqEXAROCpcaITb+b4aBLfHaTe3N3mh+2tcQs0oh/NBknIJITFDNfiPy?=
 =?us-ascii?Q?f3AEvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f73647b-1991-42e5-01ce-08dbf2ee3e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 04:22:06.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjtoADgz0JuoZiQfCUD77PT/4Ba08tD/BQW49EN1ZJIIOYVmUijcF5gx4Er8kK4qsRvd7iUqdjSPZl0YgTrfBBTpkT3EepCrTzaFMGg5I/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-Proofpoint-GUID: mIxwr4wdayQL2Ij9EPZE4r3RmfZBWpIw
X-Proofpoint-ORIG-GUID: mIxwr4wdayQL2Ij9EPZE4r3RmfZBWpIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1011 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2312020031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
> Sent: Saturday, December 2, 2023 1:50 AM
> To: sxwjean@me.com
> Cc: vbabka@suse.cz; 42.hyeyoo@gmail.com; cl@linux.com; linux-mm@kvack.org=
;
> penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com;
> roman.gushchin@linux.dev; corbet@lwn.net; arnd@arndb.de; akpm@linux-
> foundation.org; gregkh@linuxfoundation.org; linux-doc@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; Song, Xiongwei <Xiongwei.Song@windriver.com>
> Subject: Re: [PATCH 3/3] mm/slub: correct the default value of slub_min_o=
bjects in doc
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d know the
> content is safe.
>=20
> On Fri, Dec 01, 2023 at 11:15:05AM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >
> > There is no a value assigned to slub_min_objects by default, it awlays
>                                                                   ^^^^^^
> > is 0 that is intailized by compiler if no assigned value by command lin=
e.
>                ^^^^^^^^^^
> > min_objects is calculated based on proccessor numbers in
>                                      ^^^^^^^^^^
> > calculate_order(). For more details, see commit 9b2cd506e5f2 ("slub:
> > Calculate min_objects based on number of processors.")
>=20
> nit: multiple spelling mistakes here. Please double-check commit logs
> with a spell checker. :)

Sorry for those mistakes. Will update.

Regards,
Xiongwei
>=20
> >
> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > ---
> >  Documentation/mm/slub.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
> > index be75971532f5..1f4399581449 100644
> > --- a/Documentation/mm/slub.rst
> > +++ b/Documentation/mm/slub.rst
> > @@ -150,7 +150,7 @@ list_lock once in a while to deal with partial slab=
s. That overhead is
> >  governed by the order of the allocation for each slab. The allocations
> >  can be influenced by kernel parameters:
> >
> > -.. slub_min_objects=3Dx                (default 4)
> > +.. slub_min_objects=3Dx                (default 0)
> >  .. slub_min_order=3Dx          (default 0)
> >  .. slub_max_order=3Dx          (default 3 (PAGE_ALLOC_COSTLY_ORDER))
>=20
> But otherwise, yes, this change matches what the code does.
>=20
> -Kees
>=20
> --
> Kees Cook
