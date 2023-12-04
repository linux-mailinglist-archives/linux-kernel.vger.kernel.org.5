Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1355802AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjLDEia convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Dec 2023 23:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjLDEi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:38:28 -0500
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A47195;
        Sun,  3 Dec 2023 20:38:32 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3B44bnnq1195529; Mon, 4 Dec 2023 13:37:49 +0900
X-Iguazu-Qid: 2yAb1dkSkB1qyyfRbl
X-Iguazu-QSIG: v=2; s=0; t=1701664668; q=2yAb1dkSkB1qyyfRbl; m=RKfHdlI57wwmFLrsNK7iqVcLAgJXQznFzMQzm8b6AmM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1800) id 3B44blTY2250282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Dec 2023 13:37:47 +0900
X-SA-MID: 12978689
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzcDLFWqA4frbX0CayD+eUz4HVEWFQwxZI77fTXK767IkuDKUgezMrI43+a6co1ZCtAwTTXT5gCBeniiQAzKIjfv600ftFx4HeVfRxHCBa+z++M1nXn7c/8hKAKDWJLIQhknDgIv3D/49rKteRjCDn/Xhuuw2DiK8VbjW3EADjng2HpiHOmsLQK7lw5JxMy8KKq0/RvGEZiC4ogve1XIV4J8JGzp6C0DZndjaCaa02M4wLVUVAUtjkB4/HHek3KCzc8918EhXoaaLXKMRhxjkI8UZLZ8lLmr8Y8Aw7uF3peYVKG+CXd9UQHQvvle/7JAP1kdJbPy3z6r86+oVWCQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOuLvjYUz4URFroCIXPJYuigHinU+9ldLE7LkvIY1m0=;
 b=gLNffUQnQXaPXJOvBT6hRLf3kBh4Lz60X+9CA4dtpGKWm5W8QJ0AjaHhu+dqciMNWUpANMF0ZXqRi4OkH/2yv0p9PwZG2BloeZ61ry+L1oh9lf3x7IPdYhV93Tk3uv7G1IWFrv1CzdiKmTpc+PMh7+uC4GPckIcUHPJ6tWFVVlddjyo0AlL5h8VpdlCskaCkvXcDrdFRI1mbEnLncH1chKmk6doC+KWZ+gvztnLug+MMlJPzB72qgbvguMaLb19GEqgYFzcFt1ZtFDYMeRELGDcI8gvovuIlfoJADEHWZhMrlK/tNJkosbMFH6vn6zjL8k5wnP099p0iiSa2Uwth6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <sakari.ailus@iki.fi>
CC:     <hverkuil@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] documentation: media: add documentation for
 Toshiba Visconti Video Input Interface driver
Thread-Topic: [PATCH v9 4/5] documentation: media: add documentation for
 Toshiba Visconti Video Input Interface driver
Thread-Index: AQHZ/NvaHbXU7u9nIUCLRWdm6z8y6rCGd6iAgBJieMA=
Date:   Mon, 4 Dec 2023 04:32:40 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB620180FF82B8993B45FF6E0A9286A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-5-yuji2.ishikawa@toshiba.co.jp>
 <ZV3oq0szH8JjSNsc@valkosipuli.retiisi.eu>
In-Reply-To: <ZV3oq0szH8JjSNsc@valkosipuli.retiisi.eu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYWPR01MB10491:EE_
x-ms-office365-filtering-correlation-id: d1cda167-d54e-4df3-cff9-08dbf4820d60
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8WXOUNCFhWh8GEjluRlHJkIpADwseb8mPX22tSWAGtlmr3QkgCvloyacqI2nbgDCfTOQ8IUkGCb/A7l/dbInQggq2ieElSss8ZwnBx093+SOMmwcgV2bg6ndGqL8hA6soxZBqtpm9yT0Yrx0qtf1IIL2XiP7c1IJUHPxtGmwhF9TtVY0KfvEwFUgFXmdy4Ph1u+Dz6duVHt9Ek0M7sQRhABcOmGVo/4IMcu+CytYdosHBPphla6NJoR7YXsoiRjDK+6xHK1/zkulHUSLwC5foayEcDdtmsgummrxFfWHq4MA+s/9oUiv0fwLQ+bXN5NUTRN3aCCfmKPSDSCJbuGn2LY1+xPg/AYRy+5si8M2llrDoANDnvKPPXukSeQhjRQC59AcvNybbZ4/QjAbwVKs/xQ6ZA2tsP9HQjqpranaRCwhBxeajkH5iVIcQEJtSsv2w97Tt+ZWObCroeSJDn8819rLt2erli+NHk0/ui3M1sK9rR5+PKV5c/yFlB8JI9Vs2xbvcaee+hGVhzWdzhiBMPd6OZh9BWf19czA1y+aOuEY++XcRLEnkMqMIaSbARnESMX5D3LlFMDuGLThOegiLtvKqhEM0odSCVj3mhvUESWtwvvB0xN2wPogH1QaB6xU/GTUKHhQk3WUoBl4eJIsbFu9FpJh9Rs1Usy6wWQ154=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6916009)(66476007)(66556008)(76116006)(66946007)(64756008)(66446008)(316002)(54906003)(4326008)(52536014)(8936002)(8676002)(86362001)(7696005)(33656002)(9686003)(55236004)(122000001)(53546011)(6506007)(478600001)(71200400001)(38070700009)(2906002)(26005)(83380400001)(38100700002)(41300700001)(30864003)(7416002)(5660300002)(55016003)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UWVxcTlVdHJqV0oyM1JER3Q3dTNKZkoxd3hHZkkzTGMwa0RSN1BicTI1?=
 =?iso-2022-jp?B?dGNLcnc0Vm9FZi96bDhsc0hHampJWWdSNm1hVzQ0UmNXYjZRbEVmbFBU?=
 =?iso-2022-jp?B?b3M4R29VMHYvZEtCN0tJRGZTMjJVMWJHdzVyellVcXBYUHhCcFJodnRu?=
 =?iso-2022-jp?B?WEY0S3VUL1lUMnZuVjNrbjlGWmVsTWk0TXp1dENJQlpDZXU5QmpLWjRu?=
 =?iso-2022-jp?B?dERVdEYwa2g1R2VkMTYrM3JhbE5vSWhGbTBzZDJjV2lMSy9RbHBpRmxF?=
 =?iso-2022-jp?B?NEcvc2ovME01M1F2cDBMRmNQaW4ydm5aLzlyYlgrMjZmejdESmlpUEtK?=
 =?iso-2022-jp?B?ZkdodEg4TU9qaDh4amtmOXEzRGU4ZlNkSUowY0g1TVhPL3Jub1BqalZX?=
 =?iso-2022-jp?B?c3l3Q2R2ZzY2TUkwT1UwNWdnb3lYZFJVRVZ3WFZEWngwM3NBL0RoRVdv?=
 =?iso-2022-jp?B?MDhKYzZ0cmozOEJyYWhiR1FBbHoxbCtnSGcwYkx4c2I2UWtoZ3diVGxS?=
 =?iso-2022-jp?B?OS9QMEJUMllWNkt1Ry9YVVJVL1dUZzhnUlJvcVlXSG5sdHI4YlpHbUhO?=
 =?iso-2022-jp?B?cnNRYTc3L0J6OUdwN2NKMFNsY0lrWERQVHVmK3l2SVlZMHdWQ1lIcnNI?=
 =?iso-2022-jp?B?NzhYWVowdndmOXBHaGVNRlhVTFZiaVRLeHJSV2Y1TFpqd3Z1MC8vemN4?=
 =?iso-2022-jp?B?K2hjUFhlcCtyTFBBSUxNU0Jmb0RmY3FhR05EaXhFbDFFREtHSDhBSEZv?=
 =?iso-2022-jp?B?OVF1K1o1Q3JpMlhpRXRtTmZ3eGJaQ2N5Q2owbFhORFVSNU0rQ2JNMlFi?=
 =?iso-2022-jp?B?Y0FPOFpKNmFaWWI3Qm5JM0tsUWFHdEY1ZVVSQW9mTS9YOWlLWm5wSUo4?=
 =?iso-2022-jp?B?ZmpHMlhsTVRLUmFwTU81TVN0WFA0alhUc0tkeEFBdlZPdGJDc2xNeGYw?=
 =?iso-2022-jp?B?U3ZkYVBvWnZCVTdhOEtNNlgyaGIrSHVrY05UWmFPYUF4OUxPeW9OZEt1?=
 =?iso-2022-jp?B?czBFMXFzd085OGJjZzQ3aU84d2x2REF5cURKb3RyQmNGR1M4eE05S2Za?=
 =?iso-2022-jp?B?TW1tcm01a2VQMkswa05Obzd1dUVQbnpWc0RNMk9HU1Q4ZmtpMWxBMitr?=
 =?iso-2022-jp?B?c053VTJsU0xBY1h1UlloZWxRWGtVRXMvcUNVaTBrclJRTWQ2MzJtLzBU?=
 =?iso-2022-jp?B?bDh0M1Y5UFJ2SjJsMU5ycklGTzRlOUtuZ2M2dkRoZjJST0FRSi9ZZ2xG?=
 =?iso-2022-jp?B?WEVZQUVYZWJFR2UwZlBSQjF6R2pqdEs2eEpkaGdCd3FLVU1jM09pZnVQ?=
 =?iso-2022-jp?B?NlAxRldwMzd5OVFxRXl3cFVjQ0V1ckJyc2UzVHU2S2hIZmZmbmk2bVZx?=
 =?iso-2022-jp?B?UitTeE9Wbm5yUmoraDBUVkFqOTV4SFEvbUpWOVJ2dnJIbHRoVEF3aFhO?=
 =?iso-2022-jp?B?TWYra2JJbll6OVp3b09lZG5kUzVzSVQ0QWx2WHZxUTFBSG9lMVN2RE5m?=
 =?iso-2022-jp?B?NUFZR3ArZ01RZ0VrTkZIZ3FvRmNId2FKZ0UyTGlhUjBiZy83ZDBnSExT?=
 =?iso-2022-jp?B?OVFQMndXMjdLVW5BRmNyUCtoMlpFK3N6R3dSSWN0TjR3THF2eUlLaW9k?=
 =?iso-2022-jp?B?ekt2alN4cnlraDViN3Q2eFNNMHd5UGRCTE5nZGlMQ3pxTWplSndPTElJ?=
 =?iso-2022-jp?B?aGRMazYrcTFHcEs3akxDZ3NqcDE1bklRbGpGdkhpbUtLL2JZcEYvTzdF?=
 =?iso-2022-jp?B?SklPQk9qSkRYZmp6ZThYemwrQjZCb2dPZjUxQ05iMHlBRnFodVRLcWxt?=
 =?iso-2022-jp?B?Qkw5Y3lTNHVXMDlqRXRzVU5vQ0dQc1VXWjV1YzdqQkVKSGZubzI5dndJ?=
 =?iso-2022-jp?B?YlNKRkxoTEM0bi81VUlFc2lwbVB5VFZ3dWxiMWNZY093eDVHZU9scmll?=
 =?iso-2022-jp?B?SFBvd2h6WWxtckljSHIxVllvUVREU2p2ck0yRmo4ditTNkkyR1FvZXgr?=
 =?iso-2022-jp?B?NjhhS203ZDJ2blZhNm5ZelBDUFpzKzh6WnRNY1Q5WXNjcTM3bGNrQ2pG?=
 =?iso-2022-jp?B?L0tyTy9iOXR4WjRkNFRDMmk3RyswQzRtdVBEQTRsYzFuc2NuU1dVL1Vy?=
 =?iso-2022-jp?B?aytacEFhKzZZTUNpY2JlWnBGR05FdHdieERKdDRxTTl5aHJYR1I3eXpy?=
 =?iso-2022-jp?B?VGplV251MldKMFBoNUExZ2k1d01YcFNhczdBbmRtWXpqWTVUa2o4RE40?=
 =?iso-2022-jp?B?VXpvbDB6RnR6Zm45RmlrWVErd1c3a3NCV0N4V0d3dEwxamlSY2dFWWZz?=
 =?iso-2022-jp?B?a3BYdFdSakI0UWZHSVNVZ0plZnlDNnc1RGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cda167-d54e-4df3-cff9-08dbf4820d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 04:32:41.0226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ac3fsQM0CR5bA2N9AKbAJ79RxzfsbIeFXiSFiy5gMc2jaRhsVnD2qZYTUJolmwvn8iJpcNiy9If5shU3Rt/Lu25kwEi3LzvZvIlx977Y0U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10491
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sakari,
Thank you for your review.

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: Wednesday, November 22, 2023 8:40 PM
> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> <yuji2.ishikawa@toshiba.co.jp>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○
> ＯＳＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v9 4/5] documentation: media: add documentation for
> Toshiba Visconti Video Input Interface driver
> 
> Hi Yuji,
> 
> Thank you for the update and my apologies for not reviewing this properly
> earlier. Please see my commens below.
> 
> On Thu, Oct 12, 2023 at 04:13:28PM +0900, Yuji Ishikawa wrote:
> > Added basic description of Video Input Interface driver of Toshiba
> > Visconti architecture.
> > It includes hardware organization, structure of the driver and
> > description of vendor specific V4L2 controls to configure the embedded
> > image signal processor.
> >
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > ---
> > Changelog v3:
> > - Newly add documentation to describe SW and HW
> >
> > Changelog v4:
> > - no change
> >
> > Changelog v5:
> > - no change
> >
> > Changelog v6:
> > - add description of CSI2RX subdevice
> > - add ordering of ioctl(S_FMT) and ioctl(S_EXT_CTRLS)
> >
> > Changelog v7:
> > - no change
> >
> > Changelog v8:
> > - add usage of V4L2_CTRL_TYPE_VISCONTI_ISP
> >
> > Changelog v9:
> > - fix warning: set reference target for keyword
> > V4L2_CTRL_TYPE_VISCONTI_ISP
> >
> >  .../driver-api/media/drivers/index.rst        |   1 +
> >  .../media/drivers/visconti-viif.rst           | 462
> ++++++++++++++++++
> >  .../media/v4l/vidioc-g-ext-ctrls.rst          |   4 +
> >  .../media/v4l/vidioc-queryctrl.rst            |   5 +
> >  .../media/videodev2.h.rst.exceptions          |   1 +
> >  5 files changed, 473 insertions(+)
> >  create mode 100644
> > Documentation/driver-api/media/drivers/visconti-viif.rst
> >
> > diff --git a/Documentation/driver-api/media/drivers/index.rst
> > b/Documentation/driver-api/media/drivers/index.rst
> > index c4123a16b5f9..5592bd99ae5c 100644
> > --- a/Documentation/driver-api/media/drivers/index.rst
> > +++ b/Documentation/driver-api/media/drivers/index.rst
> > @@ -24,6 +24,7 @@ Video4Linux (V4L) drivers
> >  	sh_mobile_ceu_camera
> >  	tuners
> >  	vimc-devel
> > +	visconti-viif
> >  	zoran
> >  	ccs/ccs
> >
> > diff --git a/Documentation/driver-api/media/drivers/visconti-viif.rst
> > b/Documentation/driver-api/media/drivers/visconti-viif.rst
> > new file mode 100644
> > index 000000000000..fd2480cbde46
> > --- /dev/null
> > +++ b/Documentation/driver-api/media/drivers/visconti-viif.rst
> > @@ -0,0 +1,462 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============================================
> > +Visconti Video Input Interface (VIIF) Driver
> > +============================================
> > +
> > +Overview
> > +========
> > +
> > +The Visconti VIIF Hardware
> > +--------------------------
> > +
> > +The Visconti Video Input Interface (VIIF) hardware is  a proprietary
> videocapture device of Toshiba.
> > +Following function modules are integrated:
> > +
> > +* MIPI CSI2 receiver (CSI2RX)
> > +* L1 Image Signal Processor (L1ISP)
> > +
> > +  * Correction, enhancement, adjustment on RAW pictures.
> > +
> > +* L2 Image Signal Processor (L2ISP)
> > +
> > +  * Lens distortion correction
> > +  * Scaling
> > +  * Cropping
> > +
> > +* Video DMAC
> > +
> > +  * format picture (RGB, YUV, Grayscale, ...)
> > +  * write picture into DRAM
> > +
> > +Visconti5 SoC has two VIIF hardware instances.
> > +
> > +software architecture
> > +---------------------
> > +
> > +The Visconti VIIF driver is composed of following components:
> > +
> > +* (image sensor driver)
> > +* MIPI CSI2 receiver subdevice driver
> > +
> > +  * corresponding to CSI2RX
> > +
> > +* Visconti ISP subdevice driver
> > +
> > +  * corresponding to L1ISP, L2ISP (Lens distortion correction,
> > + Scaling)
> > +
> > +* Visconti Capture V4L2 device driver
> > +
> > +  * corresponding to L2ISP (Cropping) and Video DMAC
> > +  * multiple output videobuf queues
> > +
> > +    * main path0 (RGB, YUV, Grayscale, ...)
> > +    * main path1 (RGB, YUV, Grayscale, ...)
> > +    * sub path (RAW picture)
> > +
> > +::
> > +
> > +  +-----------+      +-----------+     +----------------+
> +-------------------------+
> > +  | Sensor    |      | CSI2RX    |     | ISP            |       |
> Capture MAIN PATH0      |
> > +  | subdevice | ---- | subdevice | --- | subdevice      | --+-- | V4L2 device
> |
> > +  | (IMX219)  |      | (CSI2RX)  |     | (L1ISP, L2ISP) |   |   | (L2ISP
> crop, VideoDMAC) |
> > +  +-----------+      +-----------+     +----------------+   |
> +-------------------------+
> > +                                                            |
> > +                                                            |
> +-------------------------+
> > +                                                            |   |
> Capture MAIN PATH1      |
> > +                                                            +-- |
> V4L2 device             |
> > +                                                            |   |
> (L2ISP crop, VideoDMAC) |
> > +                                                            |
> +-------------------------+
> > +                                                            |
> > +                                                            |
> +-------------------------+
> > +                                                            |   |
> Capture SUB PATH        |
> > +                                                            +-- |
> V4L2 device             |
> > +                                                                |
> (VideoDMAC)             |
> > +
> > + +-------------------------+
> > +
> > +
> > +The VIIF driver provides following device nodes for Visconti5 SoC:
> > +
> > +* VIIF0
> > +
> > +  * /dev/media0
> > +  * /dev/video0 (main path0)
> > +  * /dev/video1 (main path1)
> > +  * /dev/video2 (sub path)
> > +
> > +* VIIF1
> > +
> > +  * /dev/media1
> > +  * /dev/video3 (main path0)
> > +  * /dev/video4 (main path1)
> > +  * /dev/video5 (sub path)
> > +
> > +Use of coherent memory
> > +----------------------
> > +
> > +Visconti5 SoC has two independent DDR SDRAM controllers.
> > +Each controller is mapped to 36bit address space.
> > +
> > +Accelerator bus masters have two paths to access memory; one is
> > +directly connected to SDRAM controller, the another is connected via
> > +a cache coherency bus which keeps coherency among CPUs.
> > +
> > +From acclerators and CPUs, the address map is following:
> > +
> > +* 0x0_8000_0000 DDR0 direct access
> > +* 0x4_8000_0000 DDR0 coherency bus
> > +* 0x8_8000_0000 DDR1 direct access
> > +* 0xC_8000_0000 DDR1 coherency bus
> > +
> > +The base address can be specified with "memory" and "reserved-memory"
> > +elements in a device tree description.
> > +It's not recommended to mix direct address and coherent address.
> > +
> > +The Visconti5 VIIF driver always use only direct address to configure Video
> DMACs of the hardware.
> > +This design is to avoid great performance loss at coherency bus caused by
> massive memory access.
> > +You should not put the dma_coherent attribute to viif element in device
> tree.
> > +Cache operations are done automatically by videobuf2 driver.
> > +
> > +Tested environment
> > +------------------
> > +
> > +The Visconti VIIF driver was tested with following items:
> > +
> > +* IMX219 image sensor
> > +* IMX335 image sensor
> > +
> > +IOCTLs
> > +======
> > +
> > +Following public IOCTLs are supported
> > +
> > +* VIDIOC_QUERYCAP
> > +* VIDIOC_ENUM_FMT
> > +* VIDIOC_TRY_FMT
> > +* VIDIOC_S_FMT
> > +* VIDIOC_G_FMT
> > +* VIDIOC_ENUM_FRAMESIZES
> > +* VIDIOC_G_EXT_CTRLS
> > +* VIDIOC_S_EXT_CTRLS
> > +* VIDIOC_REQBUFS
> > +* VIDIOC_QUERYBUF
> > +* VIDIOC_QBUF
> > +* VIDIOC_EXPBUF
> > +* VIDIOC_DQBUF
> > +* VIDIOC_CREATE_BUFS
> > +* VIDIOC_PREPARE_BUF
> > +* VIDIOC_STREAMON
> > +* VIDIOC_STREAMOFF
> > +
> > +Vendor specific v4l2 controls
> > +(except for V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE and
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE) should be called
> after
> > +ioctl(S_FMT) because setting the frame format may affect valid range
> > +of parameters of the controls.
> > +
> > +Vendor specific v4l2 controls
> > +=============================
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
> > +
> > +V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE
> > +--------------------------------------------
> > +
> > +This control sets the format to pack multiple RAW pixel values into a word.
> > +
> > +This control accepts a __u32 value defined as `enum viif_rawpack_mode`.
> > +
> > +This control should be set before ioctl(S_FMT) and should not be changed
> after that.
> 
> Why do you need this? Doesn't the V4L2 pixelformat already explicitly define
> the format, including packing?
> 

This control value affects the unpacker between CSI2 receiver and ISP.
The rawpack mode is an option to receive from Wide-Dynamic-Range image sensors,
whose output bit width is larger than standard format (RAW20, RAW24).
For example, some WDR image sensors split 20 bit value into upper/lower 10bit values,
then put them into consective pixels to make a double-width RAW10 format image.

This option is only related to the interpretation of CSI2 input data.
Therefore, I think V4L2 pixel format (for resulting image) is not related to it.
The media bus format seems more relevant, but there is no corresponding definition to this case.

> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE
> > +--------------------------------------------
> > +
> > +This control sets L1ISP preprocessing mode for RAW input images.
> > +
> > +This control accepts a `struct viif_l1_input_mode_config` instance.
> > +
> > +This control should be set before ioctl(S_FMT) and should not be changed
> after that.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF
> > +-----------------------------------------------
> > +
> > +This control sets parameters to yield Y value from RGB pixel values.
> > +
> > +This control accepts a `struct viif_l1_rgb_to_y_coef_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE
> > +-----------------------------------------
> > +
> > +This control sets rules of generating analog gains for each feature in L1ISP.
> > +Related features are:
> > +
> > +* Optical Black Clamp Correction (OBCC)
> > +* Defect Pixel Correction (DPC)
> > +* RAW Color Noise Reduction (RCNR)
> > +* Lens Shading Correction (LSC)
> > +* Color matrix correction (MPRO)
> > +* Image quality adjustment (VPRO)
> > +
> > +The base gain is set with V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG
> control.
> > +
> > +This control accepts a `struct viif_l1_ag_mode_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG
> > +------------------------------------
> > +
> > +This control sets base analog gain commonly used in L1ISP features.
> > +Analog gain for each L1ISP feature is generated from the base analog
> > +gain and a configuration via
> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE control.
> > +
> > +This control accepts a `struct viif_l1_ag_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE
> > +--------------------------------------
> > +
> > +This controls sets parameters for HDR Expansion feature.
> > +
> > +This control accepts a `struct viif_l1_hdre_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION
> > +------------------------------------------------
> > +
> > +This control sets black level parameters for L1ISP inputs.
> > +
> > +This control accepts a `struct viif_l1_img_extraction_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC
> > +-------------------------------------
> > +
> > +This control sets parameters for Defect Pixel Correction.
> > +
> > +This control accepts a `struct viif_l1_dpc_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE
> > +------------------------------------------------------
> > +
> > +This control sets parameters for white balance.
> > +
> > +This control accepts a `struct viif_l1_preset_white_balance_config`
> instance.
> > +
> > +..
> _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION
> > +-----------------------------------------------------------
> > +
> > +This control sets parameters for RAW color noise reduction (RCNR) feature.
> > +
> > +This control accepts a `struct viif_l1_raw_color_noise_reduction_config`
> instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS
> > +--------------------------------------
> > +
> > +This control sets parameters for HDR synthesis.
> > +
> > +This control accepts a `struct viif_l1_hdrs_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION
> > +--------------------------------------------------------
> > +
> > +This control sets parameters for black level correction feature.
> > +
> > +This control accepts a `struct viif_l1_black_level_correction_config`
> instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC
> > +-------------------------------------
> > +
> > +This control sets parameters for Lens Shading Correction feature.
> > +L1ISP supports 2 correction methods:
> > +
> > +* parabola shading
> > +* grid shading
> > +
> > +This control accepts a `struct viif_l1_lsc_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS
> > +----------------------------------------------
> > +
> > +This controls sets parameter for the MAIN PROCESS feature which is
> composed of:
> > +
> > +* demosaic
> > +* color matrix correction
> > +
> > +This control accepts a `struct viif_l1_main_process_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB
> > +-------------------------------------
> > +
> > +This control sets parameter for auto white balance feature.
> > +
> > +This control accepts a `struct viif_l1_awb_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN
> > +-------------------------------------------
> > +
> > +This control requests enable/disable of lock for AWB gain.
> > +
> > +This control accepts a u32 value; 0 for disable lock, 1 for enable lock.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC
> > +--------------------------------------
> > +
> > +This control sets parameter for HDR Compression feature.
> > +
> > +This control accepts a `struct viif_l1_hdrc_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM
> > +------------------------------------------
> > +
> > +This control sets parameter for HDR Compression Local Tone Mapping
> feature.
> > +
> > +This control accepts a `struct viif_l1_hdrc_ltm_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA
> > +---------------------------------------
> > +
> > +This control sets parameter for gamma correction at L1ISP.
> > +
> > +This control accepts a `struct viif_l1_gamma_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT
> > +--------------------------------------------------------
> > +
> > +This control sets parameter for VPRO feature which is composed of:
> > +
> > +* luminance adjustment:
> > +
> > + * brightness adjustment
> > + * linear contrast adjusment
> > + * nonlinear contrast adjustment
> > + * luminance noise reduction
> > + * edge enhancement
> > +
> > +* chroma adjustment:
> > +
> > + * chroma suppression
> > + * color level adjustment
> > + * chroma noise reduction
> > + * coring suppression
> > + * edge chroma suppression
> > + * color noise reduction
> > +
> > +This control accepts a `struct viif_l1_img_quality_adjustment_config`
> instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION
> > +----------------------------------------------------
> > +
> > +This control sets parameter for average luminance statistics feature.
> > +
> > +This control accepts a `struct viif_l1_avg_lum_generation_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST
> > +----------------------------------------
> > +
> > +This control sets parameter for the lens undistortion feature of L2ISP.
> > +Lens undistortion parameters are defined as either or combination of
> polinomial parameter and grid table.
> > +
> > +This control accepts a `struct viif_l2_undist_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI
> > +-------------------------------------
> > +
> > +This control sets dimensions of intermediate images and scaling parameter
> of L2ISP.
> > +If you want to crop the output image, you should set crop parameter
> > +to the corresponding source pad of the ISP subdevice with media-ctl tool.
> > +
> > +This control accepts a `struct viif_l2_roi_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA:
> > +
> > +V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA
> > +---------------------------------------
> > +
> > +This control sets gamma parameter for L2ISP.
> > +
> > +This control accepts a `struct viif_l2_gamma_config` instance.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS:
> > +
> > +V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS
> > +----------------------------------------------------
> > +
> > +This control provides CSI2 receiver calibration status.
> > +
> > +This control fills a `struct viif_csi2rx_cal_status` instance with current
> status.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS:
> > +
> > +V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS
> > +--------------------------------------------
> > +
> > +This control provides CSI2 receiver error description.
> > +
> > +This control fills a `struct viif_csi2rx_err_status` instance with accumerated
> error status.
> > +Note that internal accumerated status is cleared after reading.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS:
> > +
> > +V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS
> > +----------------------------------------------
> > +
> > +This control provides status information for the last captured frame.
> > +
> > +This control fills a `struct viif_l1_info` instance with current status.
> > +
> > +.. _V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS:
> > +
> > +V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS
> > +------------------------------------------
> > +
> > +This control provides error information since the last read of this control.
> > +
> > +This control fills a `struct viif_reported_errors` instance with accumerated
> error status.
> > +Note that internal accumerated status is cleared after reading.
> > +
> > +Structures
> > +==========
> > +
> > +.. kernel-doc:: include/uapi/linux/visconti_viif.h
> 
> Instead of using controls, all ISP drivers merged within five or so years use a
> parameter buffer. This could be said as being the best known approach to pass
> the parameters to the ISP. Could you do the same here?
> 

I'll try implement parameter buffer.

> > +
> > diff --git
> > a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> > b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> > index f9f73530a6be..2f0e4f955167 100644
> > --- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> > +++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> > @@ -295,6 +295,10 @@ still cause this situation.
> >        - ``p_av1_film_grain``
> >        - A pointer to a struct :c:type:`v4l2_ctrl_av1_film_grain`. Valid if this
> control is
> >          of type ``V4L2_CTRL_TYPE_AV1_FILM_GRAIN``.
> > +    * - void *
> > +      - ``ptr``
> > +      - A pointer to Visconti ISP control specific structure. Valid if this
> control is
> > +        of type ``V4L2_CTRL_TYPE_VISCONTI_ISP``
> >      * - void *
> >        - ``ptr``
> >        - A pointer to a compound type which can be an N-dimensional
> > array diff --git
> > a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> > b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> > index 4d38acafe8e1..cd57fac8bbf9 100644
> > --- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> > +++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> > @@ -549,6 +549,11 @@ See also the examples in :ref:`control`.
> >        - n/a
> >        - A struct :c:type:`v4l2_ctrl_av1_film_grain`, containing AV1 Film
> Grain
> >          parameters for stateless video decoders.
> > +    * - ``V4L2_CTRL_TYPE_VISCONTI_ISP``
> > +      - n/a
> > +      - n/a
> > +      - n/a
> > +      - Structs specific for Visconti ISP configuration controls.
> >
> >  .. raw:: latex
> >
> > diff --git
> > a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> > b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> > index 3e58aac4ef0b..dbab7527445e 100644
> > --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> > +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> > @@ -165,6 +165,7 @@ replace symbol V4L2_CTRL_TYPE_AV1_SEQUENCE
> > :c:type:`v4l2_ctrl_type`  replace symbol
> > V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY :c:type:`v4l2_ctrl_type`
> replace
> > symbol V4L2_CTRL_TYPE_AV1_FRAME :c:type:`v4l2_ctrl_type`  replace
> > symbol V4L2_CTRL_TYPE_AV1_FILM_GRAIN :c:type:`v4l2_ctrl_type`
> > +replace symbol V4L2_CTRL_TYPE_VISCONTI_ISP :c:type:`v4l2_ctrl_type`
> >
> >  # V4L2 capability defines
> >  replace define V4L2_CAP_VIDEO_CAPTURE device-capabilities
> 
> --
> Kind regards,
> 
> Sakari Ailus

Regards,
Yuji

