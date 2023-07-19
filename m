Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59898758EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGSH2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGSH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:28:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC479E43;
        Wed, 19 Jul 2023 00:28:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so99922181fa.3;
        Wed, 19 Jul 2023 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689751682; x=1690356482;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhgGdSjvqT2IpNy0enlGxTN9uK8Itx+6lnOhxDZ5gaI=;
        b=kwksN0mX3VLmLT84PEwhDDATdzUBZYMaMpmLwsawVlAMQL4XVJRtw9UrSidNz3pRL2
         1Bvt1KqILiMC0+GT2Ebp/B8O2+/vElFHhTS0fKAVCx+rdo0ynMBFlsQg7AZ8vCPjNPsl
         3NMO/THukzhtTkSGt9zCU+AbYfgco11aKT89hFIGWfO0OoENIHiTl0AUddJWYoj9lPF9
         5QLtWD0ZCZ9lwHOgcjraMcg0m0/jUXkugEUhDT7zRZwgAr0bhTrneaeLszd4/Ufw1e+n
         Vs58N21e7SzHjL5+UZlZXWKb58XMA2B5VjqfKeKzAAgRlpwdGoHr+2lt4pPMJYdmRB1S
         zUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689751682; x=1690356482;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhgGdSjvqT2IpNy0enlGxTN9uK8Itx+6lnOhxDZ5gaI=;
        b=lYcDy3Y28t7N+1nM5keXHrMbUis6V7MG1CnxDS9e9wcWZfoxOGcH/xd/KzAsMijLY5
         6gqbmZtxfmhEe/oHxBcgy6qtP793GkWic4zz7vk61tuBwgO+ODR7YM9kWjSheJZewGNu
         OQ+kuN5Cg7fkS3IA8dgppuWciVQJoaVVEUVEhmuF72ja1Okz4iKzgjt/DUFdNXB7Kkx+
         fuBDfLqmbazqJV3otNvwSmk+RxPE1pF6BLz+sHRpHh7OdoCKnTc/p5lNLfyYmkyQrXkm
         D15hajCTPJXH1vGKKrykWJlYN7BDa/nVs6/ZvEZTdz5ec0xFHOX37bHddTw75bp7+afn
         KpzA==
X-Gm-Message-State: ABy/qLZxdrRzdhAIXtZpuTtlMpBO/gW6qMoRKkQyquYRIJ1OqZsdiyMb
        u7z+asN1kzDxlorSTHq69gUrW5mQBOQ=
X-Google-Smtp-Source: APBJJlHgqA9hMwfJUDjf0Lpw4Zp3C/tL88krc8cimPpoY6CKLsR/qs78b0dO1wUX1F2FYDbw2P3+mA==
X-Received: by 2002:a2e:3315:0:b0:2b6:f1ad:d535 with SMTP id d21-20020a2e3315000000b002b6f1add535mr12047720ljc.14.1689751681766;
        Wed, 19 Jul 2023 00:28:01 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id t10-20020a1c770a000000b003faef96ee78sm958028wmi.33.2023.07.19.00.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:28:00 -0700 (PDT)
Date:   Wed, 19 Jul 2023 09:27:37 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     Gal Pressman <gal@nvidia.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230719072733.GA13500@debian>
References: <20230707121650.GA17677@debian>
 <20230707122627.GA17845@debian>
 <7c879ceb-9133-5794-5248-f44160fec62a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c879ceb-9133-5794-5248-f44160fec62a@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gal,
Yes, I'm planning to implement all the fixes and submit a v2 in the next few days.
