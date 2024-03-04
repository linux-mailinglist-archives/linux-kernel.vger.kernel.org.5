Return-Path: <linux-kernel+bounces-91236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD992870B97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B77D1C227E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12D7AE75;
	Mon,  4 Mar 2024 20:26:39 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D454AEF9;
	Mon,  4 Mar 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583998; cv=none; b=pP/K3izD+KyX0rOuFsfoOdUaKS3YlkDMdymEDKw8TWn7rtyK2a7Q/KGwP7SaiGXqkM9QM17P9S6Apl1odr+3/zFi3ZsqqCrIE4m4QjyEN/v9cNJ63gAbVio1fYJ693TIFECYVM9QUagNZ4vBCMxRDpiwYr/35a5nkRqC+L4HgXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583998; c=relaxed/simple;
	bh=WKR5soPbdwv5SITAS4Ia+IV6JgbXybFywnXAPKGhW0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfnkMI64qo11kRev8urP05ptaUos0ubOzuoU5F+NwQ0HXQaEaolQiwHJ7lIYqWt5fyyBp4PE96lgtUEBCFgZvWb3XIAiQu7COPD1pi0Qwv0rk8p2ZO+K0Rqu8VLpFXgA+GdHwqBycdbpbuvjsFewhRU2XBLE0l832TrJyDSKURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so987154766b.0;
        Mon, 04 Mar 2024 12:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583995; x=1710188795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOo839mPdY9UDs30ip9szN5AzGukhwe6Ypv0TWThp7k=;
        b=E44KnzlOkAwC0BLvgNBpgSv0RRM2NuOLSmadcIUdPD7fz2DVY4/J/qzYGqLCnRZ/Xf
         wKaKtd/iVtoC5mD7qLHIwFi1nE9LCorDWDsdBPzHFZgO9KgRqnfD5rXtdpKMu4Pye00E
         lccUg5FIjm9axo7F+EREPHv3WUIPYDT4tnNFG+ED9kubBSZJtF1331DVNsn1eZjY7rKo
         /a+S95bniI/fBkDhG6x9T5QacJcJYCjiUTIAN/go3LEGCKwxvuLzC9Gej1kqcsjk32Nf
         MKsQUZHEZNhctAcRrCRdo1HBPDPg0cpZrZBiREDFMxBFQno/HgkTJv2HrulR4QxgxRO8
         6oWw==
X-Forwarded-Encrypted: i=1; AJvYcCWnoTIy0LiIv9tkXOqrfvAGsPHlhfR7BMzJo+fPvRuTptGHx4rxGBiexkKGGZSLMhIQhdswKYrPv0jHXkpv7HOIwfp+wbD0cGxgl1W8gPjU+RPWjbNwaMlOu6gNT4tzimGU/Dai
X-Gm-Message-State: AOJu0Ywo1xU09oueEE0br5c7ZMkqFL/jZrC9FpBoDdei774Bp9Jouw/O
	SWB/RFU3EkmEiYuiKIz0rvBn2XWIQUPccw+5Ml7HC/w8g8cU29fx
X-Google-Smtp-Source: AGHT+IFD0KaCT3wff32o4BVMJ2zpcmH0sLhAjYpku7waI4dtkjH4+BQqDaLNBgJr7bXQOoS1wxZ07g==
X-Received: by 2002:a17:906:595a:b0:a45:2678:ae55 with SMTP id g26-20020a170906595a00b00a452678ae55mr595894ejr.13.1709583995469;
        Mon, 04 Mar 2024 12:26:35 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm5236070ejq.91.2024.03.04.12.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:26:35 -0800 (PST)
Date: Mon, 4 Mar 2024 12:26:32 -0800
From: Breno Leitao <leitao@debian.org>
To: hyper <hyperlyzcs@gmail.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jitxie@tencent.com, huntazhang@tencent.com
Subject: Re: [PATCH net V2] net: pds_core: Fix possible double free in error
 handling path
Message-ID: <ZeYueIRasQTY1TzX@gmail.com>
References: <333dca5e-fae7-4684-afa8-10b8fdd48bf6@amd.com>
 <20240303084954.14498-1-hyperlyzcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303084954.14498-1-hyperlyzcs@gmail.com>

On Sun, Mar 03, 2024 at 04:49:54PM +0800, hyper wrote:
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
> calls kfree(padev) to free memory. We shouldn't call kfree(padev)
> again in the error handling path.
> 
> Fix this by cleaning up the redundant kfree() and putting
> the error handling back to where the errors happened.
> 
> Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
> Signed-off-by: hyper <hyperlyzcs@gmail.com>

I liked this v2 better.

Reviewed-by: Breno Leitao <leitao@debian.org>

