Return-Path: <linux-kernel+bounces-94462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C9B874023
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F501F266CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB813E7ED;
	Wed,  6 Mar 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kheBGuBu"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45213BAE3;
	Wed,  6 Mar 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752186; cv=none; b=KSVmLnbljQqoNA3oLAagebSTKsuAQnN/PlHIV/wiDPveCLGIPvBqn3KS6J/LqeV6zmJGPIooFFV0eCxRg+lRZsI9dEn0zwzJ4AEfK3MygPh7XObUrowT0tTwmiROaFefSfLBYZ7cRLpd/6C2RQJ396JqqEbxpSWzrHOTRgMHHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752186; c=relaxed/simple;
	bh=4L8LHyQdH8SBj7ATuuU4Uw6f2FPEEYofQRuz+BIR/yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClV3LZPdQmR2ezcW21W63dj9CiA99jVtchjc+a9ymQKIIkTQIzFvYzU6PsDXOviLsyhHtMs8MZNKfoDWLoc0bVxDQ4fhvZahXo1jD3ypkXytZDGUHlaBabvmLa60dbK2NB02svKlJTE45GG8OaUFXdOgmDIlcvEUSQtFOM4RIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kheBGuBu; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4d35b9a4b13so64551e0c.0;
        Wed, 06 Mar 2024 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752184; x=1710356984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BvLOKtxiGQGjZaRF5g17w73aFUlyA0qVFVQbFcy6f+g=;
        b=kheBGuBuiMx56rftlqNgM2sesUpZ0RzFNAb/EI6Ke5Dgyo+vEl2w1gtHAHFE9KOg0J
         ELMNfjrjIGkOokvQfFCt/9BjJ+pMumOGGb93NA24BmHUJ113MTzmDYAj0YqhcKN372X2
         LukKA0zvThhlfg1kQR1sdgZLcKHDHjcPBsVr3PBXroprBeWtYSexvECqwWwiM8K3Nns9
         wUQKUoOWNFrwBgODtgaZ2tTAOBvGPKGLy4DpWPBMprd3dpAjrWq67g//qB5ybHcvjg6a
         Pqng59QW8jtZ7l6gc6A4gnhBN30a4hZ+c6EBohetKPfccbotBErbllO1dIAPEwy2AENz
         a8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752184; x=1710356984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvLOKtxiGQGjZaRF5g17w73aFUlyA0qVFVQbFcy6f+g=;
        b=X6xDcvU3gCkf+/f0nDMj0xJ0s93GqIpuivDK783XMlFqGtaQL6ERlpPYl8lv5ox2Rp
         khHhpYFU0ndfGCGi0MIH9RmIwXB2JfOzL+TUXoAWsaRMQ+Ceh0lBai/RPChS/sc6MyCt
         QquYkZjhCPEp/Kd1CqH2vKW9qqjy7mBHKAo7tW3pUwPV2vc4v5MtES6v5pRSpPGggT/L
         A75sZpLZ8LQkoBHTGmimtqLD2ZiUBUpm4529DtcHDrg5dvgUxtrdZFZeBBXpZwKJ0anR
         VtySiDJW/I5QyRKqgZf6j1b8XqqLDoJlvs/Hx4dlMk/JYlSvs4mnRC1PlMrKyJPEW4cd
         nPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfYvxvreYkm5akpIKi9xuRDN+ID/8IDwzCDkeksFdGtp4XG7+qux5UVVmOkMhR9y4xfs3RiM+ZTNCyQu4IGjIS9AH2A1yvlxMASt9c
X-Gm-Message-State: AOJu0YymtbhAqlFLPNi/1UdBukW/J/90Cv5PpOw5Qbeom9lx5PHwh3Su
	bI+YxfWdx3g1opyweAqCq1fzkvBxnDpTFRtbzlvbx1eiowmzyJ0o3mQhLBMIZlpngltjowmEsbY
	ojl7mRp5o+NXQAvB0tH7xLa89088=
X-Google-Smtp-Source: AGHT+IEjwTFwDlSaSFYvKetNc8j6jOH06q9zwQAceNwgFjwl33dhCH2ajP3ql2biNWrFSKs/VZko3X0KPbl/qIhJ5/I=
X-Received: by 2002:a05:6122:1c82:b0:4c8:a2c6:c2be with SMTP id
 eu2-20020a0561221c8200b004c8a2c6c2bemr1659479vkb.8.1709752184153; Wed, 06 Mar
 2024 11:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305112824.448003471@linuxfoundation.org>
In-Reply-To: <20240305112824.448003471@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 6 Mar 2024 11:09:32 -0800
Message-ID: <CAOMdWSJT_zBETx2XoYOE3kCfo4VXYX=fqa1NrV3W0t9Kb5gFNg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Mar 2024 11:27:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

