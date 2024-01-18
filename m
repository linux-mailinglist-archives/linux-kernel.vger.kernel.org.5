Return-Path: <linux-kernel+bounces-30057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1183187F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3791F21281
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397BF241FB;
	Thu, 18 Jan 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T4Ou9e5X"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77507241E2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577559; cv=none; b=iZ8XvUQyipuP4c6JW0zcxZTA8LI0/F5JMVxbySqWWc92iXIp77svmzM56BdkbcSc+qNEqWfTK11ANon0ggl5UPOYcr8NNjcouOyd3i8F5217uuMR3b8phP1LdV0FGfycU9qST0jZDT+ogr9VxgVyC747KnZcaFQFRb82rD3luqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577559; c=relaxed/simple;
	bh=7X+XE/Gzv4Nomb0fLlmWLJhVAVM3P5M7gZDV8sKCsGg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TiXHVek7bXn0rDiUr3i/JfgQQF5Fp50PhIltEvifgbbluQ2NbIenYrmScIbkQLdwB2q7HgLqRxX4L0wMZAIaD8qNAR9/rMMpDtZrqqXLbL2MAuJm51YiIUaLYuMxbqGM8uEqgnqu/riIPWWBRzDJUzBXXOFNMaZQkouhvUrpoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T4Ou9e5X; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2e0be86878so119510766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705577555; x=1706182355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7X+XE/Gzv4Nomb0fLlmWLJhVAVM3P5M7gZDV8sKCsGg=;
        b=T4Ou9e5XcaUDtT+hA1UhKdNYI6UMu53OFVYkKRz2RUWrVUCmigH8AR3Pf4rNMHJmmV
         FEarapDyo1D6OJPBxjL9nJSfPhTrPP8o+uyclYjm84fRxgUKFs5BPV43Hm8G+cYRZTgq
         oFAZ1UPjpbJytrEIE87qUmVXJ5bocXaP9RsBNNNM1nS4HRAQPHs2rILGIzbq3Egq393z
         1a7cMDDRKwVQXKW8sYxeTYaT7NaK4thght6TZXE7aPIWmpKZdK2TfmLoqHWBQ1ndbG9U
         AGL1mcU++vpD3qLT43jEkDz4jFgaK/dNuGm2I4re0kiyUiO+QSu0mCdMhbq4TkGDBVVZ
         NTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705577555; x=1706182355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X+XE/Gzv4Nomb0fLlmWLJhVAVM3P5M7gZDV8sKCsGg=;
        b=GXt4QTR7iRbO1SQhVM1IHdvjwJoG7l5k3lZorftLIto93T1kELWrOMjEsILEdk8Tl4
         I2PnZENY5OT0NH8zDg1LPauALBExv8h5GkMDhrdhdP6DH7m6k5RKpi7VHfFE1XdTHE/Q
         LKSTODQKOTAKYUrMO6xLYaubhMtymeNAkpxALjJhDXq5iyY+VuQGZUiU2FJkAcflK9H2
         g0VibWtFw5lZ3Lq9q8PzvMJzRRo/ChC9+HTH2XCdtqx9sBOtkqGfc7NybVfgV1uihee+
         gyGFw+b1fVKtgvMLFkcxcM8zrhVaS02HYuIWhvaBx1O4NEgqoTvmyRuJaUVPVuJQ2BXP
         EMug==
X-Gm-Message-State: AOJu0YztnD/kUwnmq63bytwcnVv+YubUscpqZxm1Gcas3aiO06MUbm0V
	Trx4tZdgKbzbuUMvDZzg8BitGIg+GOQYhv3+UESgqMLv6AHiVdGU/nOo/qBswUk=
X-Google-Smtp-Source: AGHT+IHG5LK0M7+mQFfqN9srL30ZgOLmu9WSR0nvuerMb9IulZ2RiBgrBqFZMLSnhs02D8eEwF4Xnw==
X-Received: by 2002:a17:906:d931:b0:a2a:212:cfe5 with SMTP id rn17-20020a170906d93100b00a2a0212cfe5mr732923ejb.12.1705577555430;
        Thu, 18 Jan 2024 03:32:35 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906c19100b00a2b1a20e662sm8934043ejz.34.2024.01.18.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:32:34 -0800 (PST)
Date: Thu, 18 Jan 2024 12:32:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com
Subject: Re: [PATCH net v5 1/4] dpll: fix broken error path in
 dpll_pin_alloc(..)
Message-ID: <ZakMUbC9xLzjkZwF@nanopsycho>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
 <20240118110719.567117-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118110719.567117-2-arkadiusz.kubalewski@intel.com>

Thu, Jan 18, 2024 at 12:07:16PM CET, arkadiusz.kubalewski@intel.com wrote:
>If pin type is not expected, or dpll_pin_prop_dup(..) failed to
>allocate memory, the unwind error path shall not destroy pin's xarrays,
>which were not yet initialized.
>Add new goto label and use it to fix broken error path.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

