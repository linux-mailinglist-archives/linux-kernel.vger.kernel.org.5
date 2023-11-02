Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7077DF08B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbjKBKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbjKBKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:48:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA0E7;
        Thu,  2 Nov 2023 03:48:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so1328540a12.1;
        Thu, 02 Nov 2023 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698922096; x=1699526896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMaBjdOanD6UfLLPmERhth0x95+hV9dH23o364JxPro=;
        b=aaUxYJCx5AnCXDwJcZO1j5gnJyXeGAFTN4zH/d7mwkAp24oGnx+2qfweHkvSKiCbKi
         x6PuqrzeQKrYZOkuryVRhV6M0idTX500++t23GYaTjOFiQvgD76jlAjMq+aBNS4E2Di0
         5SYivMqQQgMDFzTcipdoTKagdXjHHr5jdX+xuSAhpTRBQCNKl5UveO8lDifmpWURKkL7
         zq9NbH/p6O9RVWY55IJ9kp5tqnI1YWJnaeNskJUHwii3Q4OQh37ip3jKuP8gZqoqvm4M
         /8kKBDoV4e0TLBd7vvMCFVv12ahMtunLZWckzqMiMWaVS7eLwmbarAiAsf6P0paQQAaq
         W3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698922096; x=1699526896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMaBjdOanD6UfLLPmERhth0x95+hV9dH23o364JxPro=;
        b=cndx9Bp0MMZYEGayjhvaoOH03R/kOsSH2hSvMpM2vECyTC/S0sULLwjtFYC3ybgtXE
         nXdnbbMNgx7usEZHuh/G6R5mpekR/9D0Lil668MDPkbgVXn+1qzmLEmH/bWjxhUixdu0
         ejjrbNUdUYA/cnTKRJIo+3x/ef6j5han10iJ1KImOqVl/mH0LTgHmJHoKst4WMeRtZbe
         lQ3NcjtBxM42ixJQ0AU9Dins56GGz90gQhn9CCkaFdTiR7Uxl4lRl31ElQPyOKPkDBmq
         u8+1DuWn7C19jKupbrdMKaW6g4Pt90J9GUEUMUifem+sHsaz2/T28+qKHRO10Qvxqmw2
         lebg==
X-Gm-Message-State: AOJu0YwZ2D8tV0SNRcFIHAD9YrNxwTDfmz0EJ+fl4tXeUBD0nJ+pcbs+
        jaAJ3G1tbNJZ9oPD9AjlAnI=
X-Google-Smtp-Source: AGHT+IFaCaMcqsAOr5kJWfaBesPw7XV+nUul5sr9n72b9RXPba2xHe0OLSJeXp4tWqlflxwgUsQo0A==
X-Received: by 2002:a50:d689:0:b0:543:5281:ac73 with SMTP id r9-20020a50d689000000b005435281ac73mr7889059edi.30.1698922095992;
        Thu, 02 Nov 2023 03:48:15 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id o15-20020aa7dd4f000000b00530a9488623sm2149246edw.46.2023.11.02.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:48:15 -0700 (PDT)
Date:   Thu, 2 Nov 2023 12:48:13 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231102104813.qyzkfpbwz4kiloez@skbuf>
References: <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
 <20231030152325.qdpvv4nbczhal35c@skbuf>
 <20231030153057.3ofydbzh7q2um3os@skbuf>
 <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
 <20231030152325.qdpvv4nbczhal35c@skbuf>
 <20231030153057.3ofydbzh7q2um3os@skbuf>
 <CACRpkdYb6v6dpFFySSHdQ0H+KYRDNr2V4ShZTVA2A0ar_h9D=A@mail.gmail.com>
 <CACRpkdYb6v6dpFFySSHdQ0H+KYRDNr2V4ShZTVA2A0ar_h9D=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYb6v6dpFFySSHdQ0H+KYRDNr2V4ShZTVA2A0ar_h9D=A@mail.gmail.com>
 <CACRpkdYb6v6dpFFySSHdQ0H+KYRDNr2V4ShZTVA2A0ar_h9D=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:22:05PM +0100, Linus Walleij wrote:
> Hi Vladimir,
> 
> I got around to testing this too:
> 
> # ping -s 1472 192.168.1.137
> 
> The result:
> 
> SKB before padding:
> 37 (192.168.1.13skb len=1514 headroom=18 headlen=1514 tailroom=260
> mac=(18,14) net=(32,20) trans=52
> shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
> csum(0xd4ef2b1 ip_summed=0 complete_sw=0 valid=0 level=0)
> hash(0x0 sw=0 l4=0) proto=0x0800 pkttype=0 iif=0
> 7): 1472 data bydev name=lan0 feat=0x0002000000005020
> tes
> sk family=2 type=3 proto=1
> 
> SKB after padding:
> skb len=1518 headroom=18 headlen=1518 tailroom=256
> mac=(18,14) net=(32,20) trans=52
> shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
> csum(0xd4ef2b1 ip_summed=0 complete_sw=0 valid=0 level=0)
> hash(0x0 sw=0 l4=0) proto=0x0800 pkttype=0 iif=0
> dev name=lan0 feat=0x0002000000005020
> sk family=2 type=3 proto=1
> 
> As expected the linear SKB is 4 bytes longer in this case.

Ok, I'm not seeing anything unusual about the skb geometry in the
skb_dump() output.
