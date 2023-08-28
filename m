Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB278A48D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjH1CQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjH1CPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:15:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A5198;
        Sun, 27 Aug 2023 19:15:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6874a386ec7so245170b3a.1;
        Sun, 27 Aug 2023 19:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693188903; x=1693793703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ue+CxuSDtyTYvwjrZI51+SYlIrMgm3DrcfChgWaBaBo=;
        b=nu5VR2Q+m1SzatCfC+hiOx+NVGpmEIkwaZr1G/mduu1Y5LvTzOcLCKxska7gXWnhLb
         mltuXuK3HtTBiIvy0jvowUXvuZpQximHM/OwQniwyH665wS4zqUSpbaFaA2GBjeecPQ2
         oJIRT2Ao3/Mow+d1AgW9QRImffrecJpH4dTPrdEDC67yFngsLtriWe37E4aIw6Jhhevw
         jBAn3x0DsZjYleT5Rx+rO+duCAbQicDoA4oITqZAUBuvjoa/2DGb2DJLwxQmyr3iwevm
         ZQl5NVWt2AzX9odPmBNw+z15Atk8uLtgGZxBADSxKzZdSuojpY99u5M+9Hg//zWZTfxg
         3A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693188903; x=1693793703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue+CxuSDtyTYvwjrZI51+SYlIrMgm3DrcfChgWaBaBo=;
        b=U5OUhO7Gv2s4Wfe6L0fzGhHizp6vRWtKJ52OeO7SGdnt58sM0455J1mn6AlZJGMKB7
         YzDMKFfk7z7Rx97ihWwQ6fnHAbif7iAd9QB2HrA8IihxuXchB2m8FCVSYi5daOy+8aBW
         uSQh5oJhjEJyLYSUhYEcS7sKp9zMMa8T7sqNqXryVp+FXUHiMmI7KTlMzrSqJBmgTtQu
         7zzTPe4sd+XODoxJdYWz0TgthUgRE18KvcUx+ANJsvvOimzWpHT+uMB8AD/tAPwfmA8a
         0vPZbpDQUVsh+3LPQcdGjK+I8qD41knu6+QuWZOaEY1Bbk+7oggI39dhjuTAyAQ/qBki
         xztg==
X-Gm-Message-State: AOJu0YwC68eo9H9d2033FvtxlBSh4vmGQOUoxydHQhiF4HCVMMJMVvdN
        E+O2HOAK3eP3BLDhV8JI4aw=
X-Google-Smtp-Source: AGHT+IHN8Fl8NxVm4qZhrKUgyN/xyGKFzRASfTqOLe7L6wZHAG3dfs74EByha7PmEEiqFWQ/Y/1/3w==
X-Received: by 2002:a05:6a00:2d88:b0:68b:68de:5848 with SMTP id fb8-20020a056a002d8800b0068b68de5848mr17170824pfb.3.1693188903353;
        Sun, 27 Aug 2023 19:15:03 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00687196f369esm5520055pfb.62.2023.08.27.19.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 19:15:02 -0700 (PDT)
Date:   Sun, 27 Aug 2023 19:15:00 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] net: stmmac: Make PTP reference clock
 references more clear
Message-ID: <ZOwDJB5cFEPGEoPk@hoboy.vegasvil.org>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
 <20230824-stmmac-subsecond-inc-cleanup-v1-7-e0b9f7c18b37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-stmmac-subsecond-inc-cleanup-v1-7-e0b9f7c18b37@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:32:58PM -0500, Andrew Halaney wrote:

> @@ -34,14 +34,14 @@ static void config_sub_second_increment(void __iomem *ioaddr,
>  	 * increment to twice the number of nanoseconds of a clock cycle.
>  	 * The calculation of the default_addend value by the caller will set it
>  	 * to mid-range = 2^31 when the remainder of this division is zero,
> -	 * which will make the accumulator overflow once every 2 ptp_clock
> +	 * which will make the accumulator overflow once every 2 clk_ptp_rate
>  	 * cycles, adding twice the number of nanoseconds of a clock cycle :
> -	 * 2 * NSEC_PER_SEC / ptp_clock.
> +	 * 2 * NSEC_PER_SEC / clk_ptp_rate.
>  	 */

This part of the driver is complete garbage.  But that isn't your fault.

Richard
