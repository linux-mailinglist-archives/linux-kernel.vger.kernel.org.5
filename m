Return-Path: <linux-kernel+bounces-125923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA9D892E43
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C947528246F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F81396;
	Sun, 31 Mar 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtuED1wn"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA2EC3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711851587; cv=none; b=RxgegcyAmQjcOHaznVu49I4orhHX9XOWyKxRO24WfC+w/Itd0IOAJ78EoGib/PV1sHtNnM63LY0MbhEjcy58ZKUZpTkRIHeOvqWiJhDsYZIaZqrKrYztTCqG2m4EbLPNTF6HIgnpu0If48EyXupJBUVTJHXFQl4UZ1VrG25gxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711851587; c=relaxed/simple;
	bh=kHilbW50FabGa+skKea/KFAapFv6c2SdbOWrBStcelU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=hr7h1Q13YqTanJEJzR9YhTXarieEPjOVo7bAOOwOXkviGVPy2m4oCRq3/T9JaW+Ja4ZejuywfNxuxqIpECh8Qy9b6yNtCyWRFG4WgF4cbrYu6odSayEszEgW//V2zJ4WBQOiPXxYXZp7S1MlWbgWlQv/4aO1FJjhghVaX1Im1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtuED1wn; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c38eced701so1807416b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711851585; x=1712456385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHilbW50FabGa+skKea/KFAapFv6c2SdbOWrBStcelU=;
        b=BtuED1wn38NxT3HDN/2zbZhFKuegYUP7pUwOhYJUD+pdNAkhOOqzMdf8eCIrsaGWGh
         aGorPgSWaLndeG/af04FuVQtlZFdkdz3VEeIn5p/V4HUigmO9GPHVwkOxYxrD5EcjkdX
         Te2r3Jn+SPdfcSZwu19D0D2Peoxb3fy/QrMM0ctORxd2s5bTB3SosahkXZtBm/YOzmpu
         w6vkLBGSKXUohP1rsfVannp3ZLtd9CHQ7M+KUXMXVeS9blEN2CL8zM8mJikNhbmX/bSe
         rM6V+fKavulLykFhuMBnFzlppPorA8zRC81taS1FD1H0SHN4msfYla+YI+2taVNEm8mI
         Uklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711851585; x=1712456385;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHilbW50FabGa+skKea/KFAapFv6c2SdbOWrBStcelU=;
        b=expvjZ3mamdAYBqK6PEwZZcnILUV7HY3rD5CDDt9yNf7y1+K1eqJMouc48RxZF2H5U
         YFHIstZnszO2ibYh+jHlIc4prEATiGonNH7K5xYjNLlORnh84M3yoL4zqiijxD3edG4J
         CRZe9sVI0zLLjkcdiCt7RJMO7qox5D6cYx/WU8p0ZahY713Et4PXusLmUQg5UaS38nSW
         aJi2FbJojFARjDfe62N7ubnkQSRBEVphskUj+YSUI9uW1f4/MK/uRRRel1UdxlEFktnP
         dkOR5zGX/0t7SXSizzGV+lIM6FbAwtBuXwjbA8wSwF/YqD8Si2E6VeK2/LUatCDxukso
         PaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdgzOwuzvq9NSkxI4+Jp/MZU2poM+X1dCMHglmX4HV+vZsIcU/yqAF2pnvuySPHKB+KjUdM+rw01bljchqQHwFDZT1G2JiB3KVzeZC
X-Gm-Message-State: AOJu0YzxdbThJWut2I3UGPKYl/gw/qHlqn7H3kgJK4iItoJoGlS5l/vm
	T3eNrqXlwb4/V4bt58e0UazLSaNtW3/MjR0WA+HArDG1YX4jMTcE
X-Google-Smtp-Source: AGHT+IGUkdXyXnx9MegUXfS8lCbdfE6rmSalJRLyGDV8JdTsSDNviU15kroqV/DfSsf9+rpBDX1OEw==
X-Received: by 2002:a05:6808:2289:b0:3c3:b99c:7b5 with SMTP id bo9-20020a056808228900b003c3b99c07b5mr7622651oib.50.1711851585482;
        Sat, 30 Mar 2024 19:19:45 -0700 (PDT)
Received: from [127.0.0.1] ([122.161.52.153])
        by smtp.gmail.com with ESMTPSA id bn2-20020a056a00324200b006eacefd8fabsm5278898pfb.64.2024.03.30.19.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 19:19:44 -0700 (PDT)
Date: Sun, 31 Mar 2024 07:49:37 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: me@wantyapps.xyz
Cc: christophe.jaillet@wanadoo.fr, frank.li@vivo.com,
	gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	luca.ceresoli@bootlin.com, prathubaronia2011@gmail.com,
	robh@kernel.org, shresthprasad7@gmail.com, skhan@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de
Message-ID: <72dc90fb-79ef-4dd4-b30e-97b1e7058156@gmail.com>
In-Reply-To: <z2ewk44rjutv24i6lqau3adrmlprj524ulqtqbncvfaj44dwcg@2dnnbm75abbp>
Subject: Re: [PATCH] staging: axis-fifo: align arguments to open parenthesis
 in axis-fifo.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <72dc90fb-79ef-4dd4-b30e-97b1e7058156@gmail.com>

Oh, that's too bad. Thanks for the heads up!

Regards,
Shresth Prasad

