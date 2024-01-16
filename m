Return-Path: <linux-kernel+bounces-27098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89A82EA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FEE1C23160
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7B11725;
	Tue, 16 Jan 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fZw9ABnV"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AF11721
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3373bc6d625so8104371f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705391214; x=1705996014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZXqicAYqWMju5/VsmDz+6yuzyI2pkNP5znHLfaye4c=;
        b=fZw9ABnV67YDRFOX6Pste44/eXIC0zb09I6R1eFAnGfnUBy8qpDODIIXixlLfwlRX8
         Hz7Sfdf5LFEkJi4gO4AxWBtlJ3cJjvK3P0FoLN4PxuKkYcckdJqPcNhiT7RZ2hVzqmDd
         kr9vI29Vgx2mDCHTtTUzi4R79iefUhBh8kGGy2rBmAikP2pKs8gUxBxA7sI/jKL/Jye1
         RUNY0suCKwRO0cahjFNzKW9/2Jo2vD0QwIHtsQrBp0AKY4Tl/7PBKFSl//8etFCSsTXt
         pTRQP8ViJF6XGwed7xTxnwrdkHhk7QS5dqVZpaCAMUOvUBr7m5vbgPgcbBU8BcT0TuRG
         6c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705391214; x=1705996014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZXqicAYqWMju5/VsmDz+6yuzyI2pkNP5znHLfaye4c=;
        b=cTfHrGCeZUxBJwN/QnN5KvtomasdILU7Yu84N/55evAM3KwFnxZfVjaEHq5rwHld00
         xB2R5BpCPL2sPHoG9aJtYtKh1PQUEnekgbSQtCS3dQzYloC+y8frD4hlii1uaR6xHF+x
         7rYRXPCM8LDrwGE2zDnbuJtdJ+Bvc3rKpuCE+OrHvlz3PAeAkTs6lEkpikpPip2bVEbC
         nH5tzTIOCyU5k6bfE7/iomL/p6afjwp4tn0MekNa8bSf8mbHVQ6m0xbbSCdWIAlZPFTz
         rpz6MbUScDeh+/FXGvkQmblBJz+pzA+GU9q57cMVAg8dH5Tcqh6H1F5Kre8Yh+KOaQUB
         VGrA==
X-Gm-Message-State: AOJu0YwQx3bwb4GxAO4RDFrZ3OfL9sz1codwVezSIrL+gnkz8rIN7Btr
	ye7T4eZM1MVxjjrtHthN4TeDte1RL91xrg==
X-Google-Smtp-Source: AGHT+IGwZUv8fkjrRpAPCaQWv2KxmRy8yB4BxE4mbNLgYwx6AJfw7FGAxD4K7n8xU0NObqeMalhcig==
X-Received: by 2002:adf:fec5:0:b0:337:6e1b:2e9f with SMTP id q5-20020adffec5000000b003376e1b2e9fmr3644019wrs.20.1705391214465;
        Mon, 15 Jan 2024 23:46:54 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d29-20020adfa35d000000b003375009accesm13919917wrb.50.2024.01.15.23.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:46:53 -0800 (PST)
Date: Tue, 16 Jan 2024 08:46:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com,
	Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH net v3 3/3] dpll: fix userspace availability of pins
Message-ID: <ZaY0bL73kDYgqh2R@nanopsycho>
References: <20240115085241.312144-1-arkadiusz.kubalewski@intel.com>
 <20240115085241.312144-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115085241.312144-4-arkadiusz.kubalewski@intel.com>

Mon, Jan 15, 2024 at 09:52:41AM CET, arkadiusz.kubalewski@intel.com wrote:
>If parent pin was unregistered but child pin was not, the userspace
>would see the "zombie" pins - the ones that were registered with
>a parent pin (dpll_pin_on_pin_register(..)).
>Technically those are not available - as there is no dpll device in the
>system. Do not dump those pins and prevent userspace from any
>interaction with them. Provide a unified function to determine if the
>pin is available and use it before acting/responding for user requests.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

The patch looks fine, but it should come before the previous one.

pw-bot: cr

Feel free to attach the review tag to the next version you send:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

