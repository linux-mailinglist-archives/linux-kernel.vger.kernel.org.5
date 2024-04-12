Return-Path: <linux-kernel+bounces-142955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2762D8A327C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C201E1F22585
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055971482F1;
	Fri, 12 Apr 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5hmx3Eu"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDA127E00;
	Fri, 12 Apr 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935877; cv=none; b=ZMdBREIOj/jvFNEUTAETHkD9iH4xRadc6gRpzmchzowFHm79e9Ygm8rj+wJdUt1Dx/gs1DBERERz1d8bdlFZ1gZ5lXG4egoBHSN22VpKo8To5OoK+PetXxlaOYYqGwceDByViLpVcKe1ClLGP/mJUb33NIJm1dhWQMmxYWqpd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935877; c=relaxed/simple;
	bh=RORODW2vJcgAPxDQ4n4yM8GRuED7G6Qf/vNl8SltkvQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ESf3voEdM2CGwLdQrrNKZ30L5X4iFVlerozO9fGe5mfa+qkgGoo8iin9vCjtxkJJ37oMHEPrQtYPR9dKf6JUazDZeHhgEYine+UPwz4Ulfas/137BQnvZ974VEKSI5oV3e8WisG4/g1Uxly3HHTxsq/0MfGa4iCHX72mHHbA1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5hmx3Eu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-699320fcbc1so6299686d6.3;
        Fri, 12 Apr 2024 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712935875; x=1713540675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTwyU2S5UHMgjSlvNflz7DIIhXgJNIRfm1/F1CcRC0o=;
        b=A5hmx3EuGPWrqkIPKgFkWSJmquyZN0esU0C8L4KbhWuJSlpH/rrZatcIIBankRPshQ
         dOOq9RM1B+Z04HNOkFSGlhJ0yT4lrnWBVtT8gVS1cSeao2J/wfxx1571nxBEzsKpYkEc
         XzX3QNOQ6N4JUi1QvrE7yfXCqOiokEc5FoWgeC515oY4UkiOKL1eU+7LEjmmzNAt2vkY
         aYBOYZyZuCmtUKkO9ZO+/MmxDFRoNPYXkc9caV1nOkwLTW1gf3RZUOvGY8tq2VTRaOhU
         ve5DOMtb1BHyWEProL28oIwITmEWKT4c3pVa04OGyJzqebB0TYA7TYwCE1wyY898PuLG
         Oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935875; x=1713540675;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTwyU2S5UHMgjSlvNflz7DIIhXgJNIRfm1/F1CcRC0o=;
        b=ViQdVaa6XG06H2vbQCBfnUC8fp3zSjawYZteb/DIyEezVtjl0eGq5JgUNSODeHPleJ
         h5PEywyD1qdk+lmBj0aOupK4TbVqgODRt7nZgWj3H1k2X15TQRAblg7/oOVMJoaVCiV2
         v1BnTUrCBYjBHyicTiOn8Y4JBEa857IyzOJY0k5JeBRvDn5wp8P9CipFwKGBTqOYFtfE
         ERbEsMYeVuC7WCmLa3vBIGSsiP9rES0nGeInAXMTIPHSxBmNVVyKBW00IQ0xWxvDFUH6
         nRgLwcpNr7uavA68c2rxs1qySZ8ZHLqbKX/FlzvT3fR8fWkewKJsnJrob+Y/v/76Zfjj
         ZVEA==
X-Forwarded-Encrypted: i=1; AJvYcCUzs7v9+V95/7MgYLUywSFBjjhdrgA/O7bYtOQHO8t27Hc9J4YJBH09dzSI1uGAF8au74UbnG6OVUU7TaH++vGncHs+sWEiB9Rs7TR0hYdwK3syKOz73lhi+vcLgl0ifv60XHW4
X-Gm-Message-State: AOJu0YwGMjO94ia00CQLyziS+uXz5WAY7GKU5n3MIg0VmPYYou0RJYrH
	6nq2QEtVBdL+ykLuBDaLxhgVk0uS29qRcM+8U4GfyvmwlVYi3nN6
X-Google-Smtp-Source: AGHT+IGpwl5BMjs4P4rDNpfocneVmf/IRgerGNtDikI537TPvh4ROvINwcgZFfzPQCFTDkPai1ibyg==
X-Received: by 2002:ad4:4f23:0:b0:69b:5445:6ab0 with SMTP id fc3-20020ad44f23000000b0069b54456ab0mr3503022qvb.46.1712935875043;
        Fri, 12 Apr 2024 08:31:15 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id i20-20020a0cf394000000b00698fa74199fsm2438981qvk.1.2024.04.12.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:31:14 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:31:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: John Fraker <jfraker@google.com>, 
 netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Shailend Chand <shailend@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Junfeng Guo <junfeng.guo@intel.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <661953c285139_38e2532941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412053245.3328123-1-jfraker@google.com>
References: <20240412053245.3328123-1-jfraker@google.com>
Subject: Re: [PATCH net-next 12] gve: Correctly report software timestamping
 capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Fraker wrote:
> gve has supported software timestamp generation since its inception,
> but has not advertised that support via ethtool. This patch correctly
> advertises that support.
> 
> Signed-off-by: John Fraker <jfraker@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> v2: Used ethtool_op_get_ts_info instead of our own implementation, as
>     suggested by Jakub

FYI: the subject says "net-next 12", not "net-next v2"
    



