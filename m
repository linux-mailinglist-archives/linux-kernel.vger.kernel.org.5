Return-Path: <linux-kernel+bounces-163518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AD8B6C72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871E01C22297
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A946551;
	Tue, 30 Apr 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="owbw4Id3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942B41232
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464296; cv=none; b=WMFvfCoiglSPN6rhEGu8B26vRBEHIkLbKOIU0qBbRSAECzzHr9cvYV7EG1pRAtuZecZqzLJspONAXKPdPHQj7JtMO8BE1K36RcUHGHAjQywvlk+oAg1vyieVElUAYMH2ps+Z26ID5uxTSb8jfK9p/UJ2PYdc56nO6CSR31etnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464296; c=relaxed/simple;
	bh=yyqGMC3ecF7zyzlbXpjgAooq2+FaYv+BZ8u/4sPaf8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTFJY2c9tQev76cghvuyELwMnFhjQt9/U33gcnme1WfJ6Wqn6yIdl+YzDEnoiSZKUY0/nYcDFtGLa2WJcRaD5KN964QkXId/5aVlBJmXkAS2c2oF4SEdeM/JX+tjqu5aC60gvQGobILwoZssTd1E7yBstB51WucTAgWO7P9AsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=owbw4Id3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so4766573e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714464293; x=1715069093; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CktYIfYvXuXuy7CBOR5eN+zm1A1ZD/8y849g6yjbOcI=;
        b=owbw4Id3cfeFypSsgqjRS8q3v+j1GoWYWoETycB/jsDEyC0xq5rnnCORGdXal36D7J
         ojVOtkRKWn42WA70M4hwNzF+2V0+m2M+9RMuTy2nUpLL0vKCas7N55cS8B1BWG0ab9ZU
         l2uYqOJay6zVKqmW1Xt22R1cwKCsHgRcEjDe9FpTyaoGyb8QlLNBMZnifZjdOdpgCTdb
         iIGQ/WksWiJkoIvMB6hrmTGkqt7aWBgXBEnqaTQrd34Yqj24ShiTZTGSyc01mjIwkz4J
         ijsxL8HqyMiGrNAXYnwtPXGNbQPom+NfHAyx+MetBpVUSO0OEZanVkF2Kb76fOTpc0Gv
         axFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464293; x=1715069093;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CktYIfYvXuXuy7CBOR5eN+zm1A1ZD/8y849g6yjbOcI=;
        b=aNO+46Ms+6VTKocBJ/aTpjWeE5h9zLGzeRuDzyrTiLe0FtWn0mbpGH/cC8KDJOhd97
         2ktF1fRaxpqcGPHhh8qkLIM8PfCIwOji8+pcFcKbGRVxoPRVuCfN3p5iJ8d86o/u2hij
         417QfPL84UGH30BA4YnPWaqN/Zs5/Sz3BBXts4cydypcwxS5pg4mm6BrH2Iu0WqAhWcG
         ujussyCulvkGmJwo1RCiXlS2sIWMYs27/4ZchDeXEYf+5aMvs5B82MvQqLELTLtE6D4n
         U3AEoi1vNoNgpgh2RNeo6mQ5lC+9riZHhbhCOLYqkUNunlgqlCWLT1UYYJebRSPPdcjg
         SBTA==
X-Forwarded-Encrypted: i=1; AJvYcCUSHX8BCH6hYO9pVugj2fL7XZCteT2iSTiFkHD3QTEMtpR5NrkMnogwgyVepSevnZ98P84crk+M1sEIroRxKF/OB/4uJ41BnIKQ9xcf
X-Gm-Message-State: AOJu0Yx3XgHFSYC3ufqFM7G0f0shbgsaX8ocVeXhktCJc5BRAjAVSVq1
	ob3Tfb6BoG++DnzqvthWd7vPagMBRm+1wWBRgF/wefasQAH3hZJCRTyndbsraUk=
X-Google-Smtp-Source: AGHT+IEvayD8itKzGc03lG3YuB4XGAi2pDN8A5ucN1FgZ298PBUVYJZOuvtOCAEf2Fzn2EaufvqnrQ==
X-Received: by 2002:a05:6512:21e:b0:51a:bd22:12a7 with SMTP id a30-20020a056512021e00b0051abd2212a7mr632107lfo.26.1714464292656;
        Tue, 30 Apr 2024 01:04:52 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24281000000b0051da687bf1fsm706240lfh.159.2024.04.30.01.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:04:52 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:04:50 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban.Veerasooran@microchip.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Message-ID: <ZjCmIn8ukC0lkRw5@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>
 <Zi94jdVg8a5MaB3E@builder>
 <eaa4eb3e-d82a-4b52-a375-1fc84be7225a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaa4eb3e-d82a-4b52-a375-1fc84be7225a@lunn.ch>

> > Additionally I figured out why my setup did not work without the HW
> > reset, I had missed a pull resistor in the schematic that held the IC in
> > reset.
> 
> Having a reset controlled by software is a pretty common
> design. Something needs to ensure the device is out of reset. It could
> be the bootloader, but i don't particularly like that, hiding away
> critical things where they are hard to see. So i think having it in
> the Linux driver is better.

Wholeheartedly agree, beyond the basics of bringing up ram, cores etc.
it becomes really weird when/if the bootloaders behaviour defines kernel
functionality.

In this case the oa_tc6 module does a soft reset and waits for a status
reg to signal ready.

What seems to be missing here is that the chip signals ready/out of
reset by asserting the irq pin and setting the RESETC bit of ther OA_STATUS0
reg (which is defined behaviour in the OA spec as I understand it).

Neither the lan865x_probe or oa_tc6_init checks for the initial
condition, but I'm guessing it's a fair assumption that the chip is out
of reset by the point when the oa_tc6_sw_reset_machphy function is
invoked.

Far as I can tell no timing information is given in the datasheet.

Might be unecessary but the setup could be made more explicit/clear
with a func such as:

int oa_tc6_out_of_reset(struct oa_tc*);

Which should be invoked before any reg access/modification code in
either oa_tc6 or the mac driver.
If this fails my (opinionated) preferred style would be to do one hw
reset, recheck, and on subsequent failure bail.

Such a change would probably lead to the HW reset being invoked on
reboots (if there is enough capacitors to keep the IC powered) and
definetly as a result of kexec calls.

> 
> There is an open question of does the driver need to actually reset
> the device, or is it sufficient to ensure it is out of reset? The
> wording of the standard suggests a hardware reset cycle is probably
> not required, but why did Microchip provide a reset pin?
> 

This has me tripped up. The lan8650/1 has a configuration write
protection mechanism with an unlock sequence, described in "4.6.3
Configuration Protection" of the datasheet.
The unlocking can be bypassed/simplified with a HW reset, still does
not seem like an explanation for the functionality.

I can't define one scenario where the HW reset is definetly necessary,
but will probably do it anyways on the systems I work on.

Ramón

