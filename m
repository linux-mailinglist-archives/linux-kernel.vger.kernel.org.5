Return-Path: <linux-kernel+bounces-146871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BAA8A6C26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0798B22A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C212CDAF;
	Tue, 16 Apr 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gptTwyKa"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577812AACE;
	Tue, 16 Apr 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273768; cv=none; b=G+70bwdEw4gaC9PYZD4IGjYYij8A5geZB0X/zL8FHcPBPe03TaunOvuwZs6or1BSK2MxEvLrO2P1RAR+iKWcgwznEgBXrh7gHTFdUSEuptjRCX03PwBPS/LQ8HU8pwrVILs/vcrb6rh1fplb/qD0R/F+xKR8B6T0zyJRnNmOTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273768; c=relaxed/simple;
	bh=1BjZEULlCLvJqv4DjncS8MZEajXmIYaXA1X0dAnpp98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdiyNKT6uNYJ5vzyQNSp+znKAHJDEaYELi+785XLY367fMXTQn3l2FrQ6d6NDfV/83+QpMpYPEtKfPNs7w7tec50vA7MUj8IU+51pOZmgg1/yNkyFc0hyVatGrJ8j5MTzsawfa6OFTuBtfTI38WMX+uxicv941Tfb84CnFSIYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gptTwyKa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2909144a12.0;
        Tue, 16 Apr 2024 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713273767; x=1713878567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NUyFM9i0rtryeQoNW8AUTADCgYG36OPoQZzM4bvcyrg=;
        b=gptTwyKaPIGx7CbGGFezkEYsD86lxBYlmJnbbfu8ili3c+37vBkjBgOoPQhKFdJKui
         5QBEg0bnUccKdgICEERjj3Y/jOXLL1aU9fw3LrJIdNZglaneYK8XG8P8cu/Ld27lBmr5
         uK0xujJhza5a6LX3RagqqfgrZq4Deovj+IqxXoVLA5wwphP7oAhoaQI6BqkzdNT6L6xf
         hWJmaMJWz0VeFZACYjb7x6QFcxo5syVRIJur/Kd+YiH2w2otxtrVSTXRC6aMvwKu4GAf
         Ejwq1EzxwiMOpx1yzdiREjtyl9SwrlHSGEFdXoLNAiYe9bIPjdIEMk1FbAStxs1J/Dcz
         vHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713273767; x=1713878567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUyFM9i0rtryeQoNW8AUTADCgYG36OPoQZzM4bvcyrg=;
        b=Wpl/7g5QSErpX9GdHB6A++ODVFvDOFKEtQhEfhDOG0NEGxuSdv9SoiwdbLgVK9FzOX
         e+m/uL3jo8SQJ/zlGTC0+2Ue2bPh4MWB7czn2WyrVKZdm2gBaSNcbo1BgfOf+M1jitzC
         QbIqffKCjlo96a4TCM9XWC4YE17532tEdihCpIVDJhuWg8auNAtR5YPMMpkgXoCs9GTA
         WW4HP4x70OdtUTieLRZOQJDc29ioWJr929vAi1ZsfxjFyLtZNPqi7r7oVnVhpuqX7HCb
         U8B3/YKVT+qFFQTNWhixDmplZpB/IXUsrq0xI/iFwn47uB3NnxodFwWop3eP/pPXX8D1
         NT1w==
X-Forwarded-Encrypted: i=1; AJvYcCWfQ4EodvKQXhzeAY9m3r+BgErU9d8NAxygoGuWMsuxwlkLUGUYm5d581SJsn5t2713dUB/mjauj407r644ew13Ct2IZogdxbwNH/gP49eJefbQ//maF/84DqfB8CqAAg+Sr75wdXS/mLxOzM2cwAVMjhbMsCk0aYvftjBTyWZ8smEc4oOUqC72O6E7AFNKaH/N+oP0eDcW2GkXehFkQCvc
X-Gm-Message-State: AOJu0YwqtAeGxrmRscc2UB4w/Z6rXSxG9o6/DArROqdOto1HqVPSUq2Z
	6fhOfvwfe5WMOcgEWAVcLyvHeFXh4AFyT1JdMn4fmgTR/A7nfnkCqz1z7qVh/yCW2QiW7z+6/Ms
	RdRaubMPIL9mkyOUl/xpsM5zKKYk=
X-Google-Smtp-Source: AGHT+IFP6210waMqO1NN+/uEDyO7Znkn9Ms/B1bjT8WrCAkXIpVxBUQKxtXXNBOYwcbWaGoZpe/UQlzDo69EIq+/22M=
X-Received: by 2002:a17:90a:ad7:b0:2a2:dcfe:bd69 with SMTP id
 r23-20020a17090a0ad700b002a2dcfebd69mr3827029pje.13.1713273766756; Tue, 16
 Apr 2024 06:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412162510.29483-1-robimarko@gmail.com> <20240416132124.GA2143558-robh@kernel.org>
In-Reply-To: <20240416132124.GA2143558-robh@kernel.org>
From: Robert Marko <robimarko@gmail.com>
Date: Tue, 16 Apr 2024 15:22:34 +0200
Message-ID: <CAOX2RU5tWt-dEA4it1G+LeNawwPqkwdG=vBBgnmdD6CNc4iywA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath11k: add
 ieee80211-freq-limit property
To: Rob Herring <robh@kernel.org>
Cc: kvalo@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, jjohnson@kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 15:21, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 12, 2024 at 06:24:08PM +0200, Robert Marko wrote:
> > This is an existing optional property that ieee80211.yaml/cfg80211
> > provides. It's useful to further restrict supported frequencies
> > for a specified device through device-tree.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml          | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> > index 672282cdfc2f..907bbb646614 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> > @@ -55,6 +55,8 @@ properties:
> >        phandle to a node describing reserved memory (System RAM memory)
> >        used by ath11k firmware (see bindings/reserved-memory/reserved-memory.txt)
> >
> > +  ieee80211-freq-limit: true
> > +
>
> Drop this and change additionalProperties to unevaluatedProperties.

Hi Rob,
This patch series has been dropped as Christian already proposed the
same before and it was reviewed.

Regards,
Robert
>
> >    iommus:
> >      minItems: 1
> >      maxItems: 2
> > @@ -88,6 +90,7 @@ required:
> >  additionalProperties: false
> >
> >  allOf:
> > +  - $ref: ieee80211.yaml#
> >    - if:
> >        properties:
> >          compatible:
> > --
> > 2.44.0
> >

