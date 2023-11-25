Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9F7F8FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 23:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjKYWjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 17:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjKYWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 17:39:47 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6080FEA;
        Sat, 25 Nov 2023 14:39:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocpls+Kd9u5f9xpTVIKs+rPrXWrcsed31qUjmAgDLXEEPj9Wrwe5LBMAoO0aG6+MkNOX5SXai1D663uk9mZByk6/lnpQbUoLDXwA/ddNPC6EKgV2r9bxjsiIXhJFsVSI8cKQHYwnmXo0cf5TzEv6grjdQQbum6mjpoq/a7iazrNqQhyAda45pitm6mcEe0bTDSIuy0Gic2eSAL1ewF9wbWclWrMtYPccozw4LxjyzS7KS8VsyHjHIJoNIvITL/igHwgb0k9ZGzpKu2MBIhGBE6FaRPq9RaEy8rjA9uOk1SGAHbVrXB3wUVvhIcCkhljWn9yjVZtZ+SzxFtUVtairUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc8h7MyMCFM/s74QT6QBbByTMUt01ouZCRThragDUuY=;
 b=MSjVq7E1rzDqoWydg+ssWFU6BfTmZpJxfpOJAKU3bMN/fbepguiwfXyiMhEqQvGOi+7xG5SSj5+cfkPmbPDXfTbn3fVn0zkzmjffBLC26SkyBcfCmvd+pzmX6/WABJ46Xu7AsIlMa8B5zNc2iNmHaYUDBrFX3amzSGfFHgKYip9OEo8BO+RZ6R66ZxeYEpSFEsc3LeLsxLnCrvUWi/pPyu/SsP74PYdgNCdEn4eUKoLcpqTdabC1wSbr2+hQhIT3DTctBfYLwIc4yBK9E/e0zTyIr6QtVPLB/3BWO7HYs/NkQKkG+1cZ4zXr3sASsRWvrcDVGgq64PwY7xHR27xk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc8h7MyMCFM/s74QT6QBbByTMUt01ouZCRThragDUuY=;
 b=otEgidex7JmNiw0urAqKVcOMX+3VjX1EHpTYkXWHRA4ElmFGVKsunpZnfJ0hxpnaRlH/QkNun9jB+e3DBTjS7I47Q9wV+MCar/HBEK5DIVVrzFjAoicYG3OM/fpi82wj2Lcb/n9WyTENO2UCQTL9nwYxpeCAFhedm8AWsk+Dbtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB7256.namprd08.prod.outlook.com
 (2603:10b6:303:f2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 22:39:48 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 22:39:47 +0000
Date:   Sat, 25 Nov 2023 16:39:44 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Anshul Dalal <anshulusr@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <ZWJ3sFfrVQA3djmi@nixie71>
References: <20231027051819.81333-1-anshulusr@gmail.com>
 <20231027051819.81333-2-anshulusr@gmail.com>
 <d1dd2142-546f-42b7-8966-ab75fd4f8817@t-8ch.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1dd2142-546f-42b7-8966-ab75fd4f8817@t-8ch.de>
X-ClientProxiedBy: DM6PR02CA0121.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::23) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7fc18b-73e4-4e5d-5c71-08dbee076da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSbTiM/HpFODn3mtmdqA1DHi1VXuX+fsj1LKIezLoZgnhaU1JJuwznjWXXA5G2/tQjYWJ6fEMfaSACu4w6BxphjdCON/zHTDT66lVzC2Tj+cex41UrDCFbgtCzriTn9irJN3S699qNHa04KbMx0mNxkhvLCkoV233LNbUWaEGgrgs1e/f//Xb++mnwNWm/1YvdRisPLbk8erDqa7hRwa6iqz2hc/aisYVtZeDpkTgD33PCJV5Ze/dBUUfnRTnLl7w/6YU7FSqGu73OAR4nofvZlY1v/imORt6c5XkAr8ipFoVxXl7n0vuBv2zyFuwFfzLiEGWmw3kfxkq6g6vUUIa0AD43+TpGf6uhcKDXkYlvWHXUSQZL8hsKzBUCpFDYwPctaJa/qgSd1JOr4jOJ2g2fT522uKRBZKgHozZhsk4RH6s47hT+FbCMFor+msN1pvxXvjU4QE/cEb8/vIGHqqjlrQrmMuZQeuUb8ftycy1IC5HnE7BMWShrW73Ua874NEAy7qcGFpLFAvm7G1UrsmSqyx0+AbsQ2/Jc/5cHP75ecfPRfsup0RRdPXoSO2lNi9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(396003)(136003)(39830400003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(33716001)(86362001)(41300700001)(4326008)(8936002)(8676002)(6916009)(54906003)(66476007)(316002)(66556008)(66946007)(9686003)(6512007)(6666004)(6506007)(478600001)(6486002)(5660300002)(7416002)(2906002)(4744005)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bG9E84EpC2FUR3qvcvhyQ/gKOfxlfgvVKuQC8p72HGlGVwUdHWa1x+0MwQ?=
 =?iso-8859-1?Q?Dme/m96Tugaz+qIxN+iCJkPNaRS7Q0irTAV6NFde1LIbS7zyDe21bd0Juk?=
 =?iso-8859-1?Q?beJNYOms+VX+VdiscV5oQ6cI/zdosiduF62UiSlsQqENzYICzw4wCrZW4/?=
 =?iso-8859-1?Q?QsOfMo8yQVdcVCOQkJbqRQAJu4fn8dG17Z/5aRcfbpDerjxC8BWa1tzcXx?=
 =?iso-8859-1?Q?f4uoBCraOUMlNKYjThvJb4rlt32/t0jvB72thtHXEj4zcxU0AHvcLqsX2w?=
 =?iso-8859-1?Q?8cILi9d4FVMiAw65qhXvxUnGCWly+rXiAqyCbQXVgbcKOdWhpuX5DIpHQf?=
 =?iso-8859-1?Q?GHSDoRfCYh7eS4L09k/ahZbPylZ5a0ALsHqi5b42pn8XU+z2Hu9S5XM9Wm?=
 =?iso-8859-1?Q?xSnnwglDQqUQZ416fjzC2vnDrreZCLvITX9wONFeAt5uwNZyvKckiaHIHg?=
 =?iso-8859-1?Q?xSxuIjuHBUtbglpZlaUf9dmznBdE3DqEzERKYzYXc5zYfLDOfACHlMztho?=
 =?iso-8859-1?Q?iDpTecp3jYCnOjjlWr2jk+3uHaWfJ9+GMTWC5zFr0zhKp4KfWAiAXNhRjX?=
 =?iso-8859-1?Q?+VEg3h7j1kHOyFjT2ii1pr3rS6Uu7pJjdR3t5AvwlIAQmesCN/mjP0QyCp?=
 =?iso-8859-1?Q?ZK5p8LcTgNDwAhAR49pCB38FsrnBPsM0KjjYdIGQmzH7hzV5skiMcUAsnd?=
 =?iso-8859-1?Q?WAsg8Wrtoc02xRh3SNCSxTNAWWC3rpLFgST6OfzRZf5xRmQj+xPf0We5QP?=
 =?iso-8859-1?Q?JZsrQdyAlxS/81R2GsnHrqAqULN1afv/0anr3b/BQ9N1JvwE1pz5kdMj0s?=
 =?iso-8859-1?Q?P3iqMnS2zy01NnDQIP4cVFO/iy8xzCp2Wl8lrp6fCgcmyqJNnyJfona8Go?=
 =?iso-8859-1?Q?pco1i0GD5LWqOUH+T+5nqgUjiiHuyuwweA8xEKBm4eZ1iX5ADwk5uX0VqV?=
 =?iso-8859-1?Q?WmuyH+D0SnQqzxZBXYJuJR2F3o/AXqqvqo4MbZKgaxaQqc6sK5Cz75NF2T?=
 =?iso-8859-1?Q?q95JBqAw8Keu8eTZUBzd9ibnwRzbgY3eZMSk8ykhEU+KA9PkrEeTPs48aE?=
 =?iso-8859-1?Q?jjN5+kT2G9I+iySZ0vF4jFTNE2M+JWpl2lmkm67Zr6FrH0ijrg2zxu4WzC?=
 =?iso-8859-1?Q?dsYxMTG8QPhSIStMS8q120hxmK6ILkl3R9HQF3AYJKTGHz8IsJvi9qKGid?=
 =?iso-8859-1?Q?y0+A3noG/qR7E6q+BEwlXxf00Z13hX2nqjLQgZm2vaTS1hk1H88X3FpIHM?=
 =?iso-8859-1?Q?2WhvWaXqjSliqqa/lPoOWaLLyYo+hJjI2bSLYshAZHGiX6r9pBlML9VSbL?=
 =?iso-8859-1?Q?hCAbQcUsbzMRK64+Ph1nYs3zc6BjijanCIXzE0D1iWGL2Xv43bJhEF6r1e?=
 =?iso-8859-1?Q?qPlP1HGgOLKxkUQwWLgR7QxnxJiORiLJu4WD3s5OvAcz27azCh2f/HgTyp?=
 =?iso-8859-1?Q?Jmk8okUJe0KIYZEiR3mWd5TsMMibRWtZ4V/f9txWB4WdfLfDLFj1gu+niv?=
 =?iso-8859-1?Q?7GfS7RsoMaUEq2CXalLT6EzjS5jNCXBY5ZZaEzWPjzHo/bflAlqMhmqrvi?=
 =?iso-8859-1?Q?evwUSMMNVJMBAsME2uIp1dwwOBF7yoMYGHL+spuhBXJXzNHxWCMRUdmoTW?=
 =?iso-8859-1?Q?3Lmb8FJkXwSJG/Y5ezt6uZPwkYTuRTbmYX?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7fc18b-73e4-4e5d-5c71-08dbee076da5
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 22:39:47.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wj7QxmTzqplEy0Xx2bCXRQcSdE7KYzZY7dfPoHnBlmLpPuCTY5l4QQAruGChyYdkBVIq+kos21c/PoK8kZfFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7256
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Anshul,

On Fri, Oct 27, 2023 at 06:14:58AM +0000, Thomas Weißschuh wrote:

[...]

> > +struct seesaw_data {
> > +	__be16 x;
> > +	__be16 y;
> 
> The fact that these are big endian is now an implementation detail
> hidden within seesaw_read_data(), so the __be16 can go away.
> 
> > +	u32 button_state;
> > +} __packed;
> 
> While this was requested by Jeff I don't think it's correct.
> The struct is never received in this form from the device.
> I guess he also got confused, like me, by the fact that data is directly
> read into the fields of the struct.

Apologies for some confusion on my part here; Thomas is correct and
my comment can be disregarded. Originally I thought this struct was
mapped to a continguous range of registers, but after studying the
documentation some more, that is clearly not the case :)

Kind regards,
Jeff LaBundy
