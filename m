Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A537DB95C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjJ3Lzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjJ3Lz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:55:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AA8C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:55:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so7339679a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698666925; x=1699271725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q31c8fnQHD+W10kmomcQ4zTSAMbkT+bVtaWYEa58nas=;
        b=HvoOMHM3zushLZ9gCVFUIC4w7Sq7a2oQf/zsEOrIJiV2h3ds3QAP5QGzzx8OOL+dRS
         sNxzjq1xK1IqleJ0U2RWCPf1GazQcoR38f0IkZvEMevVJHyA7lrZPMVym0p9b1vK5l9A
         Sdi9DCSdHxh/voEzqQ6C7id53wKrCXOXGRDHUpg2aU0N6bKaAcRwrMIhnpm7UWUEkIaa
         z4I+5xiv+JwyPIxKPDtqeE35zVMyQDdmJggjNCCaDZQ5DYE5iHHoPbo541xDR+Fi9MqX
         3QMk8i8gwj7wkGUw5BLpoqX2LZ/cvl+bYuwWfikj2XGbtHwzwZga4wuZxrgtOxfDHqZY
         yqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698666925; x=1699271725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q31c8fnQHD+W10kmomcQ4zTSAMbkT+bVtaWYEa58nas=;
        b=TWVU55wl/vJ1DlveIXmaGDwVOHcypaM3aOyDop4MnLpulXHkdZpvVZ/417mSovH2Ub
         Wx6CkD9yPvui7zxfKWGshbAqdIILDCdVawqrm518qnPv1f5mtuza8fUCk2MiKugjNBOS
         0ngdTyWobvttgRyl1+wveMVboCW7nu4PWItXGtGiTpL29NUR+Nf92KnyzU5vp6Ds6O0u
         uJvbEg2AgeNVV94SFKQLrYGtFbPA4KGmlPq3MDXwno4a7j+crIh4zfqwb7OBan4Y8nYc
         R9dun3KK7YPhHOouKKv4Im5eZ8n8qmrJ6j/CJJ0MycjHhSouBdpakiT+Au6VtKoRKIKo
         1RJA==
X-Gm-Message-State: AOJu0Yymdfc9SbRyWFA//MJmfqSH7zqMTbwNt95ZZsGMCzIg9FOTBV7z
        +H4g7tVrIr2mBs06YAov2goptA==
X-Google-Smtp-Source: AGHT+IEK0FVzrhD+/lsg/GFhSKbE3HoxQjpfS+HOYJ/lF5CE71Yh2/i3l6Z4QGe2FLuRhkkWz0rUHA==
X-Received: by 2002:a17:906:c14b:b0:9be:ab38:a362 with SMTP id dp11-20020a170906c14b00b009beab38a362mr8139316ejc.46.1698666925439;
        Mon, 30 Oct 2023 04:55:25 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lf19-20020a170906ae5300b009ad89697c86sm5944350ejb.144.2023.10.30.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:55:24 -0700 (PDT)
Date:   Mon, 30 Oct 2023 12:55:23 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
Message-ID: <ZT+Zq4j9iQj1+Xai@nanopsycho>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Oct 30, 2023 at 07:01:11AM CET, bernd.edlinger@hotmail.de wrote:
>otherwise the synopsys_id value may be read out wrong,
>because the GMAC_VERSION register might still be in reset
>state, for at least 1 us after the reset is de-asserted.
>
>Add a wait for 10 us before continuing to be on the safe side.
>
>Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
