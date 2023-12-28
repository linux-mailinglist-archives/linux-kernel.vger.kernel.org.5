Return-Path: <linux-kernel+bounces-12496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFB881F59D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00791C21BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA44401;
	Thu, 28 Dec 2023 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vutkKddQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850036FA3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-50e7aed09adso3155006e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1703749691; x=1704354491; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGr3Jb1kUUvaTFJpSrcPUwei0EV8o4OwF2pe01sQlm8=;
        b=vutkKddQ+XHh7vMwCMQ0umUsW3n2BMw7E0gwQ3zH1JVLow+4v83lGOG5uCd4qd0GOC
         iMDX2Ogvw4bkNMVRtDEf4NQ+fYqe0LXrEvWo1ZRNxiGVKBv2wUzevH1mZYAVXAHQHfDd
         jF7iH7o4AwZ0G7ar4UdaVtEoSiJ1XPE0pKJagApxdCRZIDkMXDfBEMtYBndhcPXWBl1N
         fp0F/aUMNP06zVrgaMzXRDDZfa0ew0eGJV98B0NQAtNNw533FmJTq2PqTQGByIXKIxIQ
         AR3Bfx/I1m0e6OSGh6nK+e6u/81cHw/lkrRdeafIQg2Dx0PZbv2bWeJ5LdHXGDFiWKt7
         casw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703749691; x=1704354491;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kGr3Jb1kUUvaTFJpSrcPUwei0EV8o4OwF2pe01sQlm8=;
        b=eE53fxcwg8r6CK7f0u1DcaUDg5Z1gU2VhfJkZ2tfWPo1l+PAg59YQgocJEqkHJ0kKj
         LWRNiOw7D6eYl3w8fBMUu0Kizebn2V5FnMldsXj9pJRYJYx6R/Wc9pxut7sgtcc+EeIN
         2BeFUJEtrmGDuHse98nYodzUsGm7xJAcWDDSUK1CUlLfhgy9MY3rq/nIoZ4gHKA63VGO
         kyNdgamv9N3mv08REITwOOENwEm7xsAqlswkzgocgCcvAq2l6UHAyxCBCG2CxgBJScFd
         BWzziRLJsaNXuSicXrFdNv7tCakeKTFhEYRrUWD/ErQLAYCTkUHAPPN1H3KpL/4N5ixh
         dSFQ==
X-Gm-Message-State: AOJu0YwSA90ARGVDSBn2Bn/HU5MbdpNzSWFUhj8M+lP/MW6SAdeTD0U2
	PsKSvFoXwxCS/bzZ/piMp4j1uOzmp7ndq3WpBTGQqAXHOWU5iI+yiqs=
X-Google-Smtp-Source: AGHT+IE153MQG0BpE8shs8iU209KiVsjfqeWG6GW1EqkvorXIpjahXvBEEApFyBHKh96L/YKFsTtxQ==
X-Received: by 2002:ac2:5feb:0:b0:50e:6459:529a with SMTP id s11-20020ac25feb000000b0050e6459529amr4203605lfg.21.1703749691363;
        Wed, 27 Dec 2023 23:48:11 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id mf20-20020a1709071a5400b00a26ae94444csm6408948ejc.24.2023.12.27.23.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 23:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Dec 2023 08:48:10 +0100
Message-Id: <CXZSUYSSLE12.3104IH394QMNR@fairphone.com>
To: "kernel test robot" <lkp@intel.com>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>
Cc: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>
Subject: Re: panel-raydium-rm692e5.c:undefined reference to
 `drm_dsc_pps_payload_pack'
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <202312281138.PHn1Js8S-lkp@intel.com>
In-Reply-To: <202312281138.PHn1Js8S-lkp@intel.com>

On Thu Dec 28, 2023 at 4:46 AM CET, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   f5837722ffecbbedf1b1dbab072a063565f0dad1
> commit: 988d0ff29ecf7ab750b9be29fddae588156c3d03 drm/panel: Add driver fo=
r BOE RM692E5 AMOLED panel
> date:   3 months ago
> config: csky-randconfig-001-20231228 (https://download.01.org/0day-ci/arc=
hive/20231228/202312281138.PHn1Js8S-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231228/202312281138.PHn1Js8S-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312281138.PHn1Js8S-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    csky-linux-ld: drivers/gpu/drm/panel/panel-raydium-rm692e5.o: in funct=
ion `rm692e5_prepare':
> >> panel-raydium-rm692e5.c:(.text+0xfc0): undefined reference to `drm_dsc=
_pps_payload_pack'
> >> csky-linux-ld: panel-raydium-rm692e5.c:(.text+0x1090): undefined refer=
ence to `drm_dsc_pps_payload_pack'

Should be fixed by this patch (which doesn't have to have been picked up
yet though):

https://lore.kernel.org/lkml/20231023115619.3551348-1-arnd@kernel.org/

Regards
Luca

