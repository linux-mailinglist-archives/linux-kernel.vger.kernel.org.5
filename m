Return-Path: <linux-kernel+bounces-5214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88281880C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7999B226BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A119472;
	Tue, 19 Dec 2023 12:54:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4518EA4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e3803643cso547484e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990461; x=1703595261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Hfz8xFAUymzLbsmXem+sgMO2pZjkiorAeFqQIlFWURS5TjQfX0f/nuBzrxjXtwppW8
         ZnNqdf3x/5ZxRvKCScsSfJimt7em1VMJsNlnQ3EQWjlOML8KMIYhQ9BJe1THPyQWofLY
         AfVclapO63pJKCbzx7+iKDcAUuWlS1c2ceERbh7TaAtIYpbYpNlbFP+VpVLL+VfTfQlG
         GgDfWBzKZYNLoXZlgM6xdKl2+GMZQG6OnA/YKwJZSohw+pR7SRgo/Jc+cIXup96BUX5T
         tcGR0PWgt4kMjQWlTyFGtt+s9n2MU+KLDY4mxPhiwFDujf9gXxvD35CGI2XrB1TrZPyO
         EorA==
X-Gm-Message-State: AOJu0YzL6Mevr9O1Gu0RnSpEhv7Ae/xBsnLE1GECl/udZHvlXaYHP7sl
	UI3pk+s2+P+rReohYLYPz04=
X-Google-Smtp-Source: AGHT+IExVGE8BZdfVTMiymTiwaOOwwrMWA8JMALId8k7GWu56mVfiHty5ZllMdTR/PkrEbadaT/b+Q==
X-Received: by 2002:a19:7604:0:b0:50e:3fc6:ef3e with SMTP id c4-20020a197604000000b0050e3fc6ef3emr2126318lff.4.1702990460887;
        Tue, 19 Dec 2023 04:54:20 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040d2524270asm2605490wmo.8.2023.12.19.04.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:54:20 -0800 (PST)
Message-ID: <e6827366-4abe-4241-b928-d6f1fc019375@grimberg.me>
Date: Tue, 19 Dec 2023 14:54:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] nvme: move ns id info to struct nvme_ns_head
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-2-dwagner@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231218165954.29652-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

