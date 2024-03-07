Return-Path: <linux-kernel+bounces-95326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7370874C41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B3D283F11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC2F1EEE6;
	Thu,  7 Mar 2024 10:22:05 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B02B9CA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806924; cv=none; b=LH95OPfafLm3m1eZXB/c7DZd7Q82JZEAngi2paGAPPQR/U271H+Q4WMysEUhI7mKkwywqXeYarCwah4hdwfjLjWbV/bjxXu4g2RZHMiVbvvn2oOHXRvQqJdJvHf2dmBtdoixb8flptnndR4NA7dDX3SEfo28bmcUTk8MVxMQusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806924; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxYg8gJYLLHC+b6yY37Q6UyxJS+Y4RyUYH6SbE1D1l4eW/Ed4uBnB4CEa/32BaQaa3aKRc2eScsN2PzWqI27UXK/FtkHVU9eJiVdvlCy/5ETYcjcCVhSpqtWyPtTNFwSVN8fshG1BzaO4BwcssH/3iD65p1QiccMCYTWUBuJHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso229883f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806922; x=1710411722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=c1V8BW2wTc61qYyCPOAdgcNBJ4jf17c1ge8RT+aPt1Ib39FIaujMQaOmyu/my/H/jf
         MRMZG2Z2Ok6Xj0HDcubkB8Ef5/P7/4Z+KWOg7XBUOcriGdGSi6RUtXkRrHIHMNXV7rGx
         vuoIRYkvxRcg34DO6aPObE7gotX0ITd0iuCvKk5ibZu6CJoV1HKEBJYZntRqzsfy7KUT
         emf7/b88hUlrnu0MN5htaEQXZmypknkd3HdbZ3g/WXMOGBSbQUK2OpVIgOZ8S5Nrmz3C
         XH2Oh/RoQxgpJzY2I+HkOCnRPT9KAPk1G5qRDkk2Z28fExUjYaUX9q3PWcztdeFWVacU
         wQrw==
X-Forwarded-Encrypted: i=1; AJvYcCUIqCgxlX/Qh+dZSDV7sHtCLqRr57IxV+UM4kbdLLyqR3ALUoLAfUdmpZ/fb+J7bSdW2cUQTi03PejsKKNQxBfB1Jkvu7xmV0uoyiFH
X-Gm-Message-State: AOJu0Yz8ZPtVjVrXGPOIrpwANvfioQJ35QiH4DHB5bUjfja6otNjkXxa
	U2jKjliLZ8JKMtHVeaFTxYa0dpkSbfgYxOerc7eGBd/3AreTeIVm
X-Google-Smtp-Source: AGHT+IHiESQNFFn/TLpsaU0l+IHiLBxWQfLFn84CO1s8OLpvi8fQD/7OM9POKNuAu6WpNACSXxLpVA==
X-Received: by 2002:adf:dd87:0:b0:33e:4503:3ba4 with SMTP id x7-20020adfdd87000000b0033e45033ba4mr3478250wrl.7.1709806921679;
        Thu, 07 Mar 2024 02:22:01 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id n8-20020a056000170800b0033e2291fbc0sm16579579wrc.68.2024.03.07.02.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:22:01 -0800 (PST)
Message-ID: <9e6a8168-468f-4e7a-9871-7425f1a0f109@grimberg.me>
Date: Thu, 7 Mar 2024 12:21:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] nvme-fc: rename free_ctrl callback to match name
 pattern
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240221132404.6311-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

