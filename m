Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5017F6C83
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjKXHAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKXHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:00:06 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62728D41;
        Thu, 23 Nov 2023 23:00:13 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35beca6d020so5866975ab.0;
        Thu, 23 Nov 2023 23:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700809212; x=1701414012; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXdh8tpsNpRvWJuL2gnv/V4so3ONge/pXC2S/Uan+Xo=;
        b=Y5Ydvlkvy0p+mnHdojtSk9h8tzqlY7NhcFqSyyBWrkHAUnZvVtabneiYOvA8bqultc
         NWsdFk/ocHZnVt4VwOkNHA0UK+yn9lm4ROUCU3b5VChtIJLaL5ajD3FSwDvpJxwNaZ8Z
         oxCbW3P3aOWB59Rfubf8UhbCBtRVO5eBNFenHli2uyITlOXcJnL5rwUK7zhqx8C8YrRq
         k/K8Hei7dvJ/7EVZRm3j4CcD/+7spCoziBiIWzb16w7hOd1+BbQ7NMhZnM2GHn73RI9R
         cZ6hNfgCCnB+PgVAcQEb0uwRVKQiCXepwtEQ8qIUoT7x59soCjBElPGIqFj30mfv+sXS
         qc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809213; x=1701414013;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXdh8tpsNpRvWJuL2gnv/V4so3ONge/pXC2S/Uan+Xo=;
        b=rOONgQiotsRLgAyTCJwSEjakQSbEUUCQKDFzzMk+l73Mx7YB5FmupzVLfqiPeiUxEE
         8Y0IqiE3EQxCbrQdEzHulKBQRRayRo8WbGW1zvudVAY60QB4zrSOq7gFCTgZVYu76CMN
         0HzNATq8BuxEUilQO8oNb/FpySwpTu62IgUf8W1Orn3A5ig654jq7Ywr+osH2d2GG3Ef
         p0JiYkHr9UV/5UmaOQx6mQvj20fh0Jshbil5G6DqKhZJ0/ffC5KaFzfS5xjdz69PnngT
         7hgPiuZ3RIWg5RiMMr3KRAR4j4JWn5aAovNCYbuBqpt6erVADK5LUXDCuFCqXqu+KACP
         ipvQ==
X-Gm-Message-State: AOJu0Yz+ELYogypTnS5Qn4wo/1IGLiRyOI7a1dkhqMwesuUg483qSnfG
        LlTfD38OdH0DGMzm8p+LOXQ=
X-Google-Smtp-Source: AGHT+IE91gO2XXNpvxMhHuRKUQe2+x8IIaKdsfR1Jfq7+lY6iQTS0rpBqpgRi6EKugVjkqBVsf7RZA==
X-Received: by 2002:a05:6e02:12e5:b0:35b:4731:15f3 with SMTP id l5-20020a056e0212e500b0035b473115f3mr2294682iln.10.1700809212619;
        Thu, 23 Nov 2023 23:00:12 -0800 (PST)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79150000000b006c2fcb25c15sm2226501pfi.162.2023.11.23.23.00.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Nov 2023 23:00:12 -0800 (PST)
Date:   Fri, 24 Nov 2023 16:00:06 +0900
From:   Yewon Choi <woni9911@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     threeearcat@gmail.com
Subject: xdp/xsk.c: missing read memory barrier in xsk_poll()
Message-ID: <20231124070005.GA10393@libra05>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

We found some possibility of missing read memory barrier in xsk_poll(),
so we would like to ask to check it.

commit e6762c8b adds two smp_rmb() in xsk_mmap(), which are paired with
smp_wmb() in XDP_UMEM_REG and xsk_init_queue each. The later one is
added in order to prevent reordering between reading of q and reading
of q->ring.
One example in simplied code is:

xsk_mmap():
	if (offset == XDP_PGOFF_RX_RING) {
		q = READ_ONCE(xs->rx);
	}
	...
	if (!q)
		return -EINVAL;

	/* Matches the smp_wmb() in xsk_init_queue */
	smp_rmb();
	...
	return remap_vmalloc_range(vma, q->ring, 0);

Also, the similar logic exists in xsk_poll() without smp_rmb().

xsk_poll():
	...
	if (xs->rx && !xskq_prod_is_empty(xs->rx))
		mask |= EPOLLIN | EPOLLRDNORM;
	if (xs->tx && xsk_tx_writeable(xs))
		mask |= EPOLLOUT | EPOLLWRNORM;

xskq_prod_is_empty():
	return READ_ONCE(q->ring->consumer) && ...

To be consistent, I think that smp_rmb() is needed between
xs->rx and !xsq_prod_is_empty() and the same applies for xs->tx.

Could you check this please?
If a patch is needed, we will send them.


Best Regards,
Yewon Choi
