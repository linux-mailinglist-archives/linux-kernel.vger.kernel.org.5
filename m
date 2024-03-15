Return-Path: <linux-kernel+bounces-104146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C187C9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84BA1F22DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C544915AC4;
	Fri, 15 Mar 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gzo/YaNr"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4114A98
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490300; cv=none; b=UWAPcOHlPvd8mOrZ19jlwklarzTPBZmsQ31vbVKju27IpEK9xN60lV+WGb/ZLbTuaxSiRB7rW21OwjjRG0QcRO0n4f6wdD0hbPOKSBKBjsDHTPKutE0r9BCD7EatGsl8f7U7ICqGaNK2fiHuP1T5LvSN99hYrrCF0MuesIxGy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490300; c=relaxed/simple;
	bh=s/GjHxvspqde5PDmyzE58y/UK2LQWPcFmtqDdmYzTvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STS97v5dJ7qOhMvHl/COjiXWjWMYUayFSet4p1keBTjevwecRdpbeKVJs3Cmn9uMphG1PTXbju5r4ue3TPjI0+8seFx7gC6E7eMfh1kzqzw5YAzsZPkb3VJORBzFJtYxZTcPtkyvV+akUx+Gmp/6voZ+RdbzHNd/s2zYJmZgi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gzo/YaNr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a449c5411e1so230549566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710490296; x=1711095096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/GjHxvspqde5PDmyzE58y/UK2LQWPcFmtqDdmYzTvY=;
        b=gzo/YaNrn3ifLEzU62i9u7TFYvalGfvXZsBcn8zNdzprHZ7AyuP8nUW12iudHOK7bq
         5e2nFY/dE6L5GlM6R0a2z7lzH5luCsMbOx/EK/E+xJZ5WTNWWxVbrwIj/vaQnJ8RqzUc
         /NQ37R05cgqcDwp5JIhNO+LDJKVOEYX2vNzOVL9iBGiSjXPoDCZHOmauJJ81N7FS/jdP
         K8bbEGFfd+pJHAFSZ/+aAE+UfOB4p4GPXG6rEMET9mBz+GmlG/XggYjs5QPrPzPan4Br
         sqD6Tx2ejxO48L6dVpjicDUGee4ISZXCeDZ4RpYX5vJwB68L/HDeKBWfaWrnh+U+sLkv
         nP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710490296; x=1711095096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/GjHxvspqde5PDmyzE58y/UK2LQWPcFmtqDdmYzTvY=;
        b=OS0EWF0/WES80Wgx+XNqCVDEvbYZWVbcnGepb8XkjTkK1oxnKFYTD6nJsYILyPYx4d
         7uRM1k8WPcl2zoDIwee0t+tyjo/tod7C5T8VXQSjKbzCRVlYBa3CJGQq5/acc0liY5lw
         nrq+f7UcIErXTuyeUGzjyUi60/qrf/9yob4zV/bEb6Ml3Cj0YwiHLgO2xJnm5zzPm7oU
         pPE8MVbhScTpqtQwM/tdR4HiwCO63ZT2TPZrOuZDk/ijEnBHnNW0J8M+/U2DRHDoODql
         07kJ0JBrtIG51OEi3M2cu3wyjD6cPDdkC1KRwHNgudoUULQOv4pBJuEMD3dBw1X0WP/J
         GPNA==
X-Forwarded-Encrypted: i=1; AJvYcCU2udphoH8cYb8pDribOrvkHxUN7L+ZD+Q4XJ5GbOkQI2A4Wnh0nu7aAg5Hp147yXJO/dIWzBy2by6CgyJkYVb4+oKyhsaKSelBvFan
X-Gm-Message-State: AOJu0YwkEZTh/TFI987flSf3ONWiE3gCuxLAIPiIBus0FlcpeJciveA3
	eEc5I3DH9URusa8YOc+8CCo+CmXiabIvle+xVN4CbS0TUXUHdGexGnCYZwVMKhg=
X-Google-Smtp-Source: AGHT+IHkkLwS46uOPoHgx+M42KZhCd2StM3WX/KkNEtooUlZc+lcqKpZL+XZ9e/wUMtsDkqtuWHieg==
X-Received: by 2002:a17:906:c144:b0:a46:9395:818e with SMTP id dp4-20020a170906c14400b00a469395818emr156069ejc.68.1710490296654;
        Fri, 15 Mar 2024 01:11:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709062dcb00b00a433f470cf1sm1467996eji.138.2024.03.15.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 01:11:36 -0700 (PDT)
Date: Fri, 15 Mar 2024 09:11:35 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Conor Dooley <conor@kernel.org>, Qingfang Deng <dqfext@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID: <20240315-73aa13079ef83a4559869084@orel>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>

On Wed, Mar 13, 2024 at 09:31:26AM +0800, Inochi Amaoto wrote:
..
> IMHO, it may be better to use a new DT property like "riscv,cpu-errata" or
> "<vendor>,cpu-errata". It can achieve almost everything like using pseudo
> isa. And the only cost I think is a small amount code to parse this.
>

What's the ACPI equivalent for this new DT property? If there isn't one,
then the cost is also to introduce something to the ACPI spec and add the
ACPI parsing code.

I'd much rather we call specified behaviors "extensions", whether they
are vendor-specific or RVI standard, and then treat all extensions the
same way in hardware descriptions and Linux. It'd also be best if errata
in extension implementations were handled by replacing the extension in
the hardware description with a new name which is specifically for the
behavior Linux should expect. (Just because two extensions are almost the
same doesn't mean we should say we have one and then have some second
mechanism to say, "well, not really, instead of that, it's this". It's
cleaner to just remove the extension it doesn't properly implement from
its hardware description and create a name for the behavior it does have.)

Errata in behaviors which don't have extension names (are hopefully few)
and are where mvendorid and friends would need to be checked, but then why
not create a pseudo extension name, as Conor suggests, so the rest of
Linux code can manage errata the same way it manages every other behavior?

The growth rate of the ISA bitmap is worth thinking about, though, since
we have several copies of it (at least one "all harts" bitmap, one bitmap
for each hart, another one for each vcpu, and then there's nested virt...)
We don't have enough extensions to worry about it now, but we can
eventually try partitioning, using common maps for common bits, not
storing bits which can be inferred from other bits, etc.

Thanks,
drew

