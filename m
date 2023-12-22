Return-Path: <linux-kernel+bounces-9456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24AF81C5DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B15B213F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB059476;
	Fri, 22 Dec 2023 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="lOrveDNO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6D9449;
	Fri, 22 Dec 2023 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0048204.ppops.net [127.0.0.1])
	by m0048204.ppops.net-00176a03. (8.17.1.19/8.17.1.19) with ESMTP id 3BLM4PMe020515;
	Fri, 22 Dec 2023 01:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com; h=date : from :
 to : cc : subject : message-id : references : mime-version : content-type
 : in-reply-to; s=outbound;
 bh=cae/FJnayHg64Oh6InK+iMFOgnFR3ykNfa62V/1pNqU=;
 b=lOrveDNOO5+KXQ4CzJp9kGgUM2HtYeyJE9Deqrku7N8A+wJ2bYjwSve6lZQA2y4oRVDh
 gOKfuw9LVXDCcH7xAuREx9BDlHzpugYw3GBFpxYVFHu2EpmeMDaQ1Wezcd60n/CgGVDQ
 f/CUQfkpiAKPFlA/hL8R0SAi6y2YHYohe4/YUgCCCI6VC9Ji8auqcwTlNg3mhKERWLU0
 Q0CZa8IkeQaADGDziybOXsOKPOdaLPuO/oIK3QyBOB10u7BXCL7AybTATORjtV0qIzvS
 1XmcS6VDc7W00XG2AapoNgXa8E0R40Qe5LEWm/+prMenY5UBqD3KupcymGI9oJRjDbxd Rw== 
Date: Fri, 22 Dec 2023 08:02:09 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, kernel@collabora.com,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        nandor.han@gehealthcare.com, ian.ray@gehealthcare.com
Subject: Re: EXT: Re: [PATCHv4] serial: imx: Add DMA buffer configuration via
 sysfs
Message-ID: <ZYUmYdeBZCs6B2e7@4600ffe2ac4f>
References: <20210305115058.92284-1-sebastian.reichel@collabora.com>
 <YEIetFdcuYZU98s/@kroah.com>
 <20210305124252.c3ffgca6wjqpkn45@earth.universe>
 <20210405214446.zhidvtvahcfp4wxa@earth.universe>
 <YGwKAOmlHRgEVh20@kroah.com>
 <20231208090205.ioc76sych3snjiwb@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208090205.ioc76sych3snjiwb@pengutronix.de>
X-Proofpoint-ORIG-GUID: 3xXqT6o-a7pCZ-sMkpaAQs4cXCbxLnzf
X-Proofpoint-GUID: 3xXqT6o-a7pCZ-sMkpaAQs4cXCbxLnzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_02,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxlogscore=966 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220040

On Fri, Dec 08, 2023 at 10:02:05AM +0100, Uwe Kleine-K??nig wrote:
> be safe.
> 
> Hello Greg,
> 
> [Cc += dt maintainers]
> 
> On Tue, Apr 06, 2021 at 09:13:04AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 05, 2021 at 11:44:46PM +0200, Sebastian Reichel wrote:
> > > On Fri, Mar 05, 2021 at 01:42:52PM +0100, Sebastian Reichel wrote:
> > > > On Fri, Mar 05, 2021 at 01:06:12PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Fri, Mar 05, 2021 at 12:50:58PM +0100, Sebastian Reichel wrote:
> > > > > > From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > > > > 
> > > > > > In order to optimize serial communication (performance/throughput VS
> > > > > > latency), we may need to tweak DMA period number and size. This adds
> > > > > > sysfs attributes to configure those values before initialising DMA.
> > > > > > The defaults will stay the same as before (16 buffers with a size of
> > > > > > 1024 bytes). Afterwards the values can be read/write with the
> > > > > > following sysfs files:
> > > > > > 
> > > > > > /sys/class/tty/ttymxc*/dma_buffer_size
> > > > > > /sys/class/tty/ttymxc*/dma_buffer_count
> > > > > 
> > > > > Ick no.  Custom sysfs attributes for things like serial ports are crazy.
> > > > > 
> > > > > > This is mainly needed for GEHC CS ONE (arch/arm/boot/dts/imx53-ppd.dts),
> > > > > > which has multiple microcontrollers connected via UART controlling. One
> > > > > > of the UARTs is connected to an on-board microcontroller at 19200 baud,
> > > > > > which constantly pushes critical data (so aging character detect
> > > > > > interrupt will never trigger). This data must be processed at 50-200 Hz,
> > > > > > so UART should return data in less than 5-20ms. With 1024 byte DMA
> > > > > > buffer (and a constant data stream) the read operation instead needs
> > > > > > 1024 byte / 19200 baud = 53.333ms, which is way too long (note: Worst
> > > > > > Case would be remote processor sending data with short pauses <= 7
> > > > > > characters, which would further increase this number). The current
> > > > > > downstream kernel instead configures 24 bytes resulting in 1.25ms,
> > > > > > but that is obviously not sensible for normal UART use cases and cannot
> > > > > > be used as new default.
> > > > > 
> > > > > Why can't this be a device tree attribute? Why does this have to be a
> > > > > sysfs thing that no one will know how to tune and set over time.  This
> > > > > hardware should not force a user to manually tune it to get it to work
> > > > > properly, this isn't the 1990's anymore :(
> > > > > 
> > > > > Please never force a user to choose stuff like this, they never will
> > > > > know what to do.
> > > > 
> > > > This used to be a DT attribute in PATCHv1. It has been moved over to
> > > > sysfs since PATCHv2, since it does not describe the hardware, but
> > > > configuration. Unfortunately lore.kernel.org does not have the full
> > > > thread, but this is the discussion:
> > > > 
> > > > https://lore.kernel.org/linux-serial/20170629182618.jpahpmuq364ldcv2@pengutronix.de/
> > > > 
> > > > From downstream POV this can be done either by adding a DT property
> > > > to the UART node, or by adding a udev rule.
> > > > 
> > > > From my POV there is not a huge difference. In both cases we will
> > > > be bound by an ABI afterwards, in both cases people will usually
> > > > stick to the default value and in both cases people that do deviate
> > > > from the default probably ran into problems and started to look
> > > > for a solution.
> > > 
> > > ping? It's not very nice to get a rejected in cycles :(
> > 
> > I recommend working with the DT people here, as custom sysfs attributes
> > for things like this that are really just describing the hardware is
> > crazy.

Continuing here (see also [1]).

[1] https://lore.kernel.org/lkml/ZXr55QV4tnCz8GtI@4600ffe2ac4f/

> 
> I was one who expressed concerns in the earlier rounds that dt isn't the
> right place for this. dt is about hardware description, but choosing
> a good value for the dma buffer size is driver tuning and depends on the
> individual requirements. (latency, throughput, memory consumption,
> robustness under system load). I can even imagine use cases where the
> settings should be changed dynamically, which cannot (easily) be done
> using dt.
> 
> While I see your point that a driver specific sysfs property is
> unusual/strange/whatever every downside you mentioned also applies to a
> dt property (or a custom ioctl).
> 
> Among the solutions I can imagine, my preference order is:
> 
>  - automatic tuning

This might be too magical.  The algorithm would likely lose data before
it "warms up" and that would be unacceptable to our application.

>  - sysfs property
>  - further discussion
>  - dt property
>  - custom ioctl

- sysctl

Given the description [2] "configure kernel parameters at runtime" this
approach would appear to meet our needs.  I have not looked into this in
any detail yet -- but would like to get upstream feedback.

[2] https://man7.org/linux/man-pages/man8/sysctl.8.html

> 
> I wonder if there is a sensible way to implement a automatic tuning. In
> the use case mentioned in the commit log, Sebastian's need is low
> latency for a constantly sending microcontroller on the other side. Is
> it sensible to make the used dma buffers smaller if we have a certain
> throughput? Or is that too magic and doomed to fail covering most use
> cases? If that doesn't work, I support Sebastian's approach to do that
> in a sysfs property.
> 
> Sebastian, have you evaluated just not using dma for these UARTs?

We spent a significant amount of time analysing and profiling our
application.  DMA is absolutely required in order to avoid dropping
data.

This is especially true for the 4M baud UART.  This section quoted from
the original patch V4 [3].

[3] https://lore.kernel.org/lkml/20210305115058.92284-1-sebastian.reichel@collabora.com/

> The same device also has another microcontroller with a 4M baud UART
> connection exchanging lots of data. For this the same mechanism can
> be used to increase the buffer size (downstream uses 4K instead of
> the default 1K) with potentially slightly reduced buffer count. At
> this baud rate latency is not an issue (4096 byte / 4M baud = 0.977 ms).
> Before increasing the default buffer count from 4 to 16 in 76c38d30fee7,
> this was required to avoid data loss. With the changed default it's
> a performance optimization.

Note: Quite a lot has change since we submitted this patch -- GE
HealthCare has spun-off from GE, and Sebastian is no longer working on
the project.

Many thanks,
Ian

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



