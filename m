Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C19777A18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjHJOEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjHJOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:04:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5910426A9;
        Thu, 10 Aug 2023 07:04:21 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63d30554eefso5881376d6.3;
        Thu, 10 Aug 2023 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691676260; x=1692281060;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvw8YvdgNBQrpsheEQ2rQUvV3iq1U97lLZrULuXMDMs=;
        b=MT6tgtnaPVBnDX1/jqNuZTikjkdy/v7dbMQcgYVXfQDEneiPJDdbLoAi6RSDSyYZLe
         Yz5fdQuOkXLbFf+CREPHQBav9P9kC/lwhAANwrnpV0ROj/Sl2shYVSPsQ+/3XXM1Ng6b
         5yg+GrasWSnc5Kcx1QWDEPNf/OpoFcqEGwfp6eUN8FxEy7KLdP5mq1JxTfl46p3X+wTx
         HV421oyUX6EPdNboTTA3tCFOFsJb3pTOlITfzEJoMolSkV/Wiyqw6tX6H2G0knKW9dD9
         we2RbbGuYvti3h0t3Yoxcdx3TjBi8m7cZl8idxX0lCVctcK21cBote/q1c5mmgRvcw6f
         /kgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676260; x=1692281060;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bvw8YvdgNBQrpsheEQ2rQUvV3iq1U97lLZrULuXMDMs=;
        b=b2xtVHdI4n5m4lmDdh1AWvbNcKBNE1wvnt0L558lryVfZTzmMWTMXRe3E++YcH2kbL
         SWIeHMqrEYixGKkF98Kyk/lxhcBYozdQocF39Kcdj2huBTWgmlnfURiYTz7y+23JSjS4
         QCBi9fAgi30LyLW9JqjFmx6Me2WP5jisgWChb4/63L7mX4aIDfLguN9g2qve+RYCk5QO
         +dwm5wWOuSy5vA3R6qCidmP5ASDhQOQYjriqLLskSYSzmiwY9UTZYPOMrjl5SnDUQsiv
         EoxeT0iLXd8MRiA81ml8I5lfKhMmawrgvyRj0B2DKER/c1fxE9FwfHw5101ck0LZHb1r
         Q0+w==
X-Gm-Message-State: AOJu0Yxlvc4v0WrN4J50UNeZcj6jc1e+VocgKJkE0WdKO9+SqPOFxi3N
        vRl4ZfTbqbWOt4GORCf4LSg=
X-Google-Smtp-Source: AGHT+IEa19gHa+xwfMPcikqOiNgjQXbBoYvmyyHFcu3B3sagWhL9r8l0C0lLB86O9aTgEoSci5WBhw==
X-Received: by 2002:a05:6214:5283:b0:639:91ad:64d6 with SMTP id kj3-20020a056214528300b0063991ad64d6mr2357058qvb.61.1691676260347;
        Thu, 10 Aug 2023 07:04:20 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id d5-20020a0cdb05000000b0062b76c29978sm504864qvk.6.2023.08.10.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:04:19 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:04:19 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Tahsin Erdogan <trdgn@amazon.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <64d4ee63a11e9_8e54c294a9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230809164753.2247594-1-trdgn@amazon.com>
References: <20230809164753.2247594-1-trdgn@amazon.com>
Subject: Re: [PATCH v4] tun: avoid high-order page allocation for packet
 header
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tahsin Erdogan wrote:
> When gso.hdr_len is zero and a packet is transmitted via write() or
> writev(), all payload is treated as header which requires a contiguous
> memory allocation. This allocation request is harder to satisfy, and may
> even fail if there is enough fragmentation.
> 
> Note that sendmsg() code path limits the linear copy length, so this change
> makes write()/writev() and sendmsg() paths more consistent.
> 
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

