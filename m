Return-Path: <linux-kernel+bounces-129786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09F896FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8909285D29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC48147C8E;
	Wed,  3 Apr 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rplqtbXe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773626DD0D;
	Wed,  3 Apr 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149816; cv=none; b=fHTanKukK0DT4PL6duf/hLrn08F+fNYjyXWN6EZLZjoJaXUsXj3EduYmdNMWl58hatJfbObV+57w05JlatCKxHRDpI1rU7k+ptGI6GpxFr+EQIoXjubBICeRtW0W3xtXc5JiMZ0sXpG9cN8xUOr1eNrQdcPE8ytL2gjcS/Yzw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149816; c=relaxed/simple;
	bh=yvrsRkBk9aRhM8YpIPbxmremyPzTyz4GLvGwKFycmHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKlB0fdL2+hdbbXNh3S/FY+eqa5YUcYqo3qxcKNpLC9rUcZAaJyXuYMSxHxFjuKvdsC/mUAsyR3GPOcBjlY6FQR07y70DPsT4hjkVopxq541RLzcm+ZGFZF2AwmvjryGRd7U7T7P2xDNU13daoDsZpJvxUl5uuHrnCmuJ5OgtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rplqtbXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51789C433F1;
	Wed,  3 Apr 2024 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712149816;
	bh=yvrsRkBk9aRhM8YpIPbxmremyPzTyz4GLvGwKFycmHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rplqtbXe3rTpglp6yFhQT/hMhZ1Yajr2SwJJ2eIpPJeKPPlKH3g4j1N0ir40ET+Vk
	 ZW/awo4L/yjIezZHOiQ9F2CdOkXtus3SIO4pKMkQSQcQjYySRXS/Lgm/7pQap5tFgw
	 Ouzw2fgm7648Ffj9m34QylesK5euZr0M8l9499dY=
Date: Wed, 3 Apr 2024 15:10:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
Message-ID: <2024040349-labrador-corporate-cb6c@gregkh>
References: <20240401152553.125349965@linuxfoundation.org>
 <CA+G9fYvc8axBi9Hm_WDac5v-4DiDmiFuKxk=Ghx80obEO9Uknw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvc8axBi9Hm_WDac5v-4DiDmiFuKxk=Ghx80obEO9Uknw@mail.gmail.com>

On Tue, Apr 02, 2024 at 02:42:29PM +0530, Naresh Kamboju wrote:
> On Mon, 1 Apr 2024 at 21:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Note, this will be the LAST 6.7.y kernel release.  After this one it
> > will be end-of-life.  Please move to 6.8.y now.
> >
> > ------------------------------------------
> >
> > This is the start of the stable review cycle for the 6.7.12 release.
> > There are 432 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> Regressions on arm64, arm, x86_64, and i386 with libgpiod tests.
> 
> libgpiod test regressions noticed on Linux stable-rc 6.8, 6.7 and 6.6
> and Linux next and mainline master.
> 
> Anders bisected and found this first bad commit,
>   gpio: cdev: sanitize the label before requesting the interrupt
>   commit b34490879baa847d16fc529c8ea6e6d34f004b38 upstream.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> LKFT is running libgpiod test suite version
>   v2.0.1-0-gae275c3 (and also tested v2.1)
> 
> libgpiod
>   - _gpiod_edge-event_edge_event_wait_timeout
>   - _gpiod_edge-event_event_copy
>   - _gpiod_edge-event_null_buffer
>   - _gpiod_edge-event_read_both_events
>   - _gpiod_edge-event_read_both_events_blocking
>   - _gpiod_edge-event_read_falling_edge_event
>   - _gpiod_edge-event_read_rising_edge_event
>   - _gpiod_edge-event_read_rising_edge_event_polled
>   - _gpiod_edge-event_reading_more_events_than_the_queue_contains_doesnt_block
>   - _gpiod_edge-event_seqno
>   - _gpiod_line-info_edge_detection_settings
> 
> Test log:
> -------
> ok 16 /gpiod/edge-event/edge_event_buffer_max_capacity
> **
> gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_timeout:
> '_request' should not be NULL
> # gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_timeout:
> '_request' should not be NULL
> not ok 17 /gpiod/edge-event/edge_event_wait_timeout
> ok 18 /gpiod/edge-event/cannot_request_lines_in_output_mode_with_edge_detection
> **
> gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events:
> '_request' should not be NULL
> # gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events:
> '_request' should not be NULL
> not ok 19 /gpiod/edge-event/read_both_events
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.11-433-gb15156435f06/testrun/23252698/suite/libgpiod/tests/

I'm going to drop the gpio change and make it for the next round of
stable kernels, so we don't get this regression.

thanks,

greg k-h

