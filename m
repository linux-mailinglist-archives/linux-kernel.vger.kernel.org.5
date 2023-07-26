Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8530763B73
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjGZPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjGZPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:43:29 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D3212B;
        Wed, 26 Jul 2023 08:43:26 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bb6334fec5so360075fac.1;
        Wed, 26 Jul 2023 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690386206; x=1690991006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GgFvlAGeua6rkHRPoDyX/+JWDNQ8FgMvtlCof0tD8t4=;
        b=RMArvMwJxEoqM7oM+2jJtH+rbGnNw2G9JiIwJG6hsgAf9RiedtfRmXrb5dmsFNY9UW
         AHgdI1ToGQr4XBGX2YNwEmtv5r/fMatcmSO1nBwGM9M0rjGJqs/oB8fwrZff4HxAHX8B
         00OpQZz+LNjdDZed8f5qjMOvn5NoMIv2SKxlpSGhPoxO8qwnBzROvCqT3P3/dPNvVriz
         7vgjeGHAeN1fPuYC+gETeVHmnu9TCJ8DJjZW7sUZkF/SZiwACYE4VaTciKpj+evW0/2s
         GcXhRmHG9g2+TuOyiFPK9GvuynmwHs63fcWsRqItpiONgSt8c3rh9cA9DcPkAtG6RJ5b
         IzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386206; x=1690991006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgFvlAGeua6rkHRPoDyX/+JWDNQ8FgMvtlCof0tD8t4=;
        b=BIRY17/XX87LYSY15qMLhSTbR+9Yylwzu9Ytem7pL4l7L2hbPaxHEtG896l1I4d0+J
         KcN5If69s2y9QMXWpg+E0zblcSIhvsVY8OjHccS69oBHyJCKelTdu84LqWC9Q/whSofE
         OjkoR8D7SgE6Ar2xQWcxjHHSmQ7TcXWpvdXD0y9UzmZM9h78/XnRLJiSKZdEeGrrs0q5
         wZQwr5DLiCgDybuFm31Khl0IkbJhxNyK+gacwObhs4EmUHDKP3WInLfF8DaIPV5FW+US
         CMObLPwBJcyE7axa0wlhQDuIHpYHPdf1dwMsn0H0l2DUlE4b8kcgU/B6TcHSvXXE5LVS
         PHhg==
X-Gm-Message-State: ABy/qLY2KMjTZmTxATzpaGsUK6uzkUrvgTqWhhwO+Jwx0QrXnYJBuFbB
        oyroSmWBJgbXBrKW9OdNti4=
X-Google-Smtp-Source: APBJJlH5TY7cNT9lCf4suTEQwBH46hx7lkSTs+i74ILJmSnyjHQ/it17SRxuPKv6AOjsfdVhaVHhhA==
X-Received: by 2002:a05:6870:fba9:b0:1ba:bea1:b970 with SMTP id kv41-20020a056870fba900b001babea1b970mr2443328oab.5.1690386205632;
        Wed, 26 Jul 2023 08:43:25 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id fw3-20020a17090b128300b00262ca945cecsm1399094pjb.54.2023.07.26.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:43:25 -0700 (PDT)
Date:   Wed, 26 Jul 2023 08:43:22 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org>
 <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:10:35AM +0200, Johannes Zink wrote:

> Also on a side-note, "driver nonsense" sounds a bit harsh from someone
> always insisting that one should not compensate for bad drivers in the
> userspace stack and instead fixing driver and hardware issues in the kernel,
> don't you think?

Everything has its place.

The proper place to account for delay asymmetries is in the user space
configuration, for example in linuxptp you have

       delayAsymmetry
              The  time  difference in nanoseconds of the transmit and receive
              paths. This value should be positive when  the  server-to-client
              propagation  time  is  longer  and  negative when the client-to-
              server time is longer. The default is 0 nanoseconds.

       egressLatency
              Specifies the  difference  in  nanoseconds  between  the  actual
              transmission time at the reference plane and the reported trans‐
              mit time stamp. This value will be added to egress  time  stamps
              obtained from the hardware.  The default is 0.

       ingressLatency
              Specifies the difference in nanoseconds between the reported re‐
              ceive  time  stamp  and  the  actual reception time at reference
              plane. This value will be subtracted from  ingress  time  stamps
              obtained from the hardware.  The default is 0.

Trying to hard code those into the driver?  Good luck getting that
right for everyone.

BTW this driver is actually for an IP core used in many, many SoCs.

How many _other_ SoCs did you test your patch on?

Thanks,
Richard

