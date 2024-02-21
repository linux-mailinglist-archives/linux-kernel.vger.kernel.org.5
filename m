Return-Path: <linux-kernel+bounces-75299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998285E611
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F72A284DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FE885940;
	Wed, 21 Feb 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jt0Cd1zb"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266F3C068
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540356; cv=none; b=EPlZqHEBCvi6QKFxsl/A9m9/2cv9ZUUSO7OaxRXd74wp51eazbBe+1Y0soDS3bBOEFTT6D9LwbMGUuzTl8KA0MhpiCEtBAKZpG/mjQRtltaNJQf9v26mpQUaxOqHTxGEsJfaqgnYFyPzklC5sHkNMPInNP8MQ6hd2wYOqNz529g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540356; c=relaxed/simple;
	bh=huu2hWz+NSGDR1cCL7Z963qagQlNiSvksrY9h0TiL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuOgPBf4duYS79f+r1T0wuD7m1gM40ieF2hUqBWnwvk9a3OccJbnoXCC+8h47i+V0SXwJrIiAQ/ITyCMM4dLZM/F7rNu/NrR1KgIMCENm10iDtPx/5u+5i2vhwsNALHhB2XqgB6kfU0sKufho815tFvzK9bL5A71CHqSsp36UEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jt0Cd1zb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d6fe64a9bso1691248f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708540353; x=1709145153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdCNHUB8NlhEWaYuHhsXiudAInPYTn2vq7tNOUbWmbI=;
        b=Jt0Cd1zblFmKyzbK1yXyjzWBD6MThIh03wyhxTP89KIffyhvFElQn0DHY3zJeg37nh
         ab56GpXNvN/mIlcV6uI+d5tVTJ8Acm/MxWTzqD6S3ZSo/jh00YfvyRVcVU5sqSQYJZLD
         YOxtxRJ5jmT5dOBXP32fdlJut82WvLBRCt6EFLbqN3uyeURPYdUg3VvI73DiVRMJ+PWj
         vasgxBYxD0rdqv6XZsFYdXU5CyDAmOACO+Q4Y64T5xFFu8jGV8UGVibf/nzgqRTslnoB
         t9sSVlfdILEWaskUba4oyTxHZkYfyUg3XlaSge1iXoWlxRopSC6rnuSOPK6Me3HeWCBV
         nIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540353; x=1709145153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdCNHUB8NlhEWaYuHhsXiudAInPYTn2vq7tNOUbWmbI=;
        b=XebFAnUqNqZcnJKIITwjW0yLIr+4Xut5lTq+CkBt50bny6Ye+rWPulIsl1KA+4iMOx
         huZa4w/8vkCexHzTCxKi5UWfwB5w4E6mUhPr63kLhMhLv0EvEQ4EyN5QtqzAmMUGSxhy
         l2d/79J53I9smwpK5NbDRm82o5EbdSWMydPzwq78HARkI1/Ot6wU+/NiTzIsg6xSN1np
         fjFhwWS7V3KoEOtQCMtmHnzcY4X7q6fxQTGchnadA5lH0s8t5Hw74DS7IOSGXfCdyuap
         9oUFI423Eg07DzT0n7nUTK9Ur8uC08Y8EC07dKmsN2Xmkf6PTuT4hx/zj+l+w9pLQc1Q
         Bsqw==
X-Forwarded-Encrypted: i=1; AJvYcCXvVkzpUROUT2dK8uqaXIEPB8oYogIqJKuFo4dyohpNTbPLVbK4TOIoGV9r7jPqGehXhuvy7Y6mfh29WWKnUuEAluBYarJ9S4dGXCn/
X-Gm-Message-State: AOJu0YwuJ8kk5r7PLg0I45iA+W4GxkSpOoATqYBlGQ9TcOdD8kwiCPKM
	LOnsKgd0oIGGpeIPYZFO6jgTpNWezS6boYZ9nAWWA4aotvARP73OXnUJSBDNmDY=
X-Google-Smtp-Source: AGHT+IGjjh41J8R6w1HgLCzLEhL+yAFtNJQ8Did+W2yZkuwwHAhhY4N1gRhnvSo6GKC5QbcXWFhzlA==
X-Received: by 2002:a05:6000:809:b0:33d:1656:21fa with SMTP id bt9-20020a056000080900b0033d165621famr19010789wrb.24.1708540352842;
        Wed, 21 Feb 2024 10:32:32 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bx14-20020a5d5b0e000000b0033d6bd4eab9sm6552101wrb.1.2024.02.21.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:32:32 -0800 (PST)
Date: Wed, 21 Feb 2024 21:32:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>, Geoff Levand <geoff@infradead.org>
Cc: Geoff Levand <geoff@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net] ps3/gelic: Fix possible NULL pointer dereference
Message-ID: <d8cfc517-f597-420b-a164-1d33f3117b93@moroto.mountain>
References: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>

This driver is PPC so I have never looked at the code before.  I noticed
another issue that was introduced last December in commit 3ce4f9c3fbb3
("net/ps3_gelic_net: Add gelic_descr structures").

net/ethernet/toshiba/ps3_gelic_net.c
   375  static int gelic_descr_prepare_rx(struct gelic_card *card,
   376                                    struct gelic_descr *descr)
   377  {
   378          static const unsigned int rx_skb_size =
   379                  ALIGN(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN) +
   380                  GELIC_NET_RXBUF_ALIGN - 1;
   381          dma_addr_t cpu_addr;
   382          int offset;
   383  
   384          if (gelic_descr_get_status(descr) !=  GELIC_DESCR_DMA_NOT_IN_USE)
   385                  dev_info(ctodev(card), "%s: ERROR status\n", __func__);
   386  
   387          descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
   388          if (!descr->skb) {
   389                  descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
   390                  return -ENOMEM;
   391          }
   392          descr->hw_regs.dmac_cmd_status = 0;
   393          descr->hw_regs.result_size = 0;
   394          descr->hw_regs.valid_size = 0;
   395          descr->hw_regs.data_error = 0;
   396          descr->hw_regs.payload.dev_addr = 0;
   397          descr->hw_regs.payload.size = 0;
   398          descr->skb = NULL;
                ^^^^^^^^^^^^^^^^^^
NULL

   399  
   400          offset = ((unsigned long)descr->skb->data) &
                                         ^^^^^^^^^^^^
Dereferenced here.

   401                  (GELIC_NET_RXBUF_ALIGN - 1);
   402          if (offset)
   403                  skb_reserve(descr->skb, GELIC_NET_RXBUF_ALIGN - offset);
   404          /* io-mmu-map the skb */
   405          cpu_addr = dma_map_single(ctodev(card), descr->skb->data,
   406                                    GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);

regards,
dan carpenter


