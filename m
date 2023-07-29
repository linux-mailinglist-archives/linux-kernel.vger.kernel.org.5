Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC6176809A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjG2Qav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjG2Qau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 12:30:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7AF1FE7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690648233; x=1691253033; i=efault@gmx.de;
 bh=hgG/l05zVWFqD8Wm7E9Fcn7k50YcoFrm7l23NrcoDz0=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=i59PH5evLs+yet6/VOAbBG5GKSxvg5DTDEyQ9vjPNEH0iDWMfxkkLE/7B2iHNMvyLJEn0JJ
 +DB6wbfOeXaEAVKqcSzGc4Y/fHydN2ZGnTjhvP6bV82F8Mj29ZETRCWgHiFEPcFRGY2xAI04P
 JP2LlPboUzHzzPDheneeDob1UDV+zPW0dGez9sfU15/lqFfSUw4oBQMxgw9iyaDVnUTpkIOkn
 L7JjsMV/Wrj5yxcaJPys7X88Li2FAZ6/fpulv+TR8f5Ux0jAtuel6LYuRoqQwVYL2L/5REihc
 HJbaat1HH14T9Jag/eUuwGJH6W7bHQt6oG0vSM215O8Grb/RCq6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.157]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw3N-1pzlTW0Vfv-00izlB; Sat, 29
 Jul 2023 18:30:33 +0200
Message-ID: <332489cfef9b7eb1bd4180ee499f90a263126b81.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Sat, 29 Jul 2023 18:30:32 +0200
In-Reply-To: <1620591d2201c1498f2832b32d26efd0c5cdd5cf.camel@gmx.de>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <1620591d2201c1498f2832b32d26efd0c5cdd5cf.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w0mE6uIYucmBpqI2Fw252gC00RNq4Zq/ZlpvIJ9js6vc10YMsPC
 BxOiKIOh2qSw5ZZ6wpV8ayKxhlVNPAWHdkOVRxRao/YSH/bKGhwRnf8MD0QoiKqO9IuNSFQ
 Os/LrtBFiDWhMKY6mgljHgiaCPGgYAPnj1NNOgAL0fIsJGbF0gDMIEm5KCtt7KAxACXlzpj
 eOH9MCYIqsbW3yJtYKbbg==
UI-OutboundReport: notjunk:1;M01:P0:UMopMcsB+9Y=;AXPebn+b90w1G5T6VQ3/3PUOlR/
 NtlJKUiOb8memNnWyno94Qao61M2PRWtU01bgLC65HxFQryqDf8fm7i97c7oJDpr+Y1ajkhWC
 RebNbiNyF/k+Z/dVnXUFI+wlE2Vu07YVGsyobNxNfDoAUlDHSGU/Fl0JkjnVUNJ9ZaBQZ4FY/
 6pE47XalB4kYLvhx/Eg7xnXm8iIINBXowTGLlWb4Jzy/lbCWD1g0cAq2GEbEKy4Q5H8IQt/Z+
 0+W+WXj2UCWNv7TF+sEvqhpSvGLKmUBeT9ZnDm8sLErLBH8BYBluLZiJkdHEGzipPUuMpYwfK
 rj3B092yIQux8jAhnsiEP+wATg8M65ABhWsKEiQDpOV4S0NJ130g65wszXr9v6fq0aTC8w5NA
 WdoiH0C4B+HldfgYxEnwyRklemPmxlmUsYSoeWeZ4UYt/CCHn85ki9UJzFMai6lIuzirXCMII
 z1GSY0lL3kTN5uw110oLRK9/xP4kQsZg0yHmfMOCpobEJao+tfOxpGXej8fZHCf24xK45hQSQ
 VDKPTS0nL8z0dkk2bWVCCttwpXzAdyETyNxRb0trcGrds37nqYvPDKGSf2jM1glqEV8p2IQ0E
 0ABuhTTvpnZHQ7Gu2sGoJKk2qfz6VkLXoRpBLrmNmVLkJtWYvlDnjxkK3U79Q3f016jgVT3RJ
 72yZV+p6ShU+2mFoMb6aG53qiKQGnMCiyPEj1Q3HOEPdAqDE38rHebXyl+JF6w4qMpDLFQTcD
 /MFN0Oo6pJ0jXpoUxVD4p3T3bEX/aUrI8CHbfpT3qB6CcdOJ8wO54TNm572CfmwGl/3+OZY09
 igLvK8Mv4g+6FJE2zgr2hvgyXzTXQ89wIYqJwyFRiZoAsnPsjEoXgzwDxun1CQ2buv7r2Qq5Q
 eSc3JIl77VmGKH+PSUCrjmjX+FU3DcQ8WgPhMEFs3f7Cqhjgn6gJGkfRgBS6foNMBzAp5KgGa
 gLoUdACdzt0FvxNWRql3s1tfSvE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 17:12 +0200, Mike Galbraith wrote:
>
> The oops arrived with 2e1c0170771e, _but_ it turns out to be somehow
> config related.=C2=A0 The obese distro config rolled forward does not oo=
ps...

It would have had I actually set PROC_KCORE before building the thing.

	-Mike
