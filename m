Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A2805F62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjLEU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:26:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34D181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:26:36 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d075392ff6so1326655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701807996; x=1702412796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z74VK0/+6LO3YLMu3vX1pNpETdyfXDf+myVrrbMuLo=;
        b=JG4DvRLtvWmVfw20cYFSjcl9zNlGRd5KelOqqOfkJcHjsr4Yu1GcbZ4/alONixRIXf
         5gbOwbAObvGJwsYT5xBNidZrPOUWZgPGAXagnIxjP69lc208iXywdIz+wucnnAOb2mu5
         0BAItnq4Al82m2lexHOwqDZyfi/tzBkA0miRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701807996; x=1702412796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z74VK0/+6LO3YLMu3vX1pNpETdyfXDf+myVrrbMuLo=;
        b=Pr1KldpturG4KPI8eqGkrFOm9G55KEfAYzOobGNUqU9MDVoIf4sA+k6oZCcq7QO8cN
         nJ9ED9n1qMzrJVpv7AzR2uUdQQBN/4cCva3QadKYRD8V8vl7xU5vK9RjcFdbX8/VSX6o
         rLcIP/Uz4iAh6ss7R8vRVi1H0ZtgADCvVE81uXMq6UxlpWqxqTb+fjRaUQF0oQuJmLft
         pwVV4qYcZ6azglh25yyLc7ZkbyNUC4Ymt0IMqIQIlDMXTRrsFryiOprQNYka05RhuEcv
         3zV/fvjy/UJvenBw4b4QH3Ke0dofxD8mXc0ViUJ8euQdFx6+AqpkWFFDUZr/JhmrJ+xM
         TP8w==
X-Gm-Message-State: AOJu0YzGCViQKSV0Q+cAU/aNIxv/WmPA5cTj1TA6k1rvptBFeAF71Tgl
        LHdb7eKtBifftUcfe5a23DBe2Q==
X-Google-Smtp-Source: AGHT+IHukR9UvjD9j4+NWOK/ZZO7ah/LCGSa2/TGIMPKzLjm0beERmGnqBUyNqFynnETTlRIEgT0Dw==
X-Received: by 2002:a17:902:f545:b0:1d0:b3c4:a269 with SMTP id h5-20020a170902f54500b001d0b3c4a269mr2255897plf.13.1701807996133;
        Tue, 05 Dec 2023 12:26:36 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5038:905b:ae7e:e6da])
        by smtp.gmail.com with UTF8SMTPSA id y11-20020a170902700b00b001cc29ffcd96sm4156496plk.192.2023.12.05.12.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 12:26:35 -0800 (PST)
Date:   Tue, 5 Dec 2023 12:26:32 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: added extra delay for firmware ready.
Message-ID: <ZW-HeGCvxpqzBukB@google.com>
References: <20231128082544.613179-1-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128082544.613179-1-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:25:44PM +0800, David Lin wrote:
> For SDIO IW416, in a corner case FW may return ready before complete full
> initialization.
> Command timeout may occur at driver load after reboot.

Do you have any idea why? Is it specific to this chip and/or firmware?
I'm hesitant to add magic sleeps to everything, just because you have
one buggy chip/firmware.

If it's a known issue with a single chip, it seems like you should add a
flag to struct mwifiex_sdio_device / mwifiex_sdio_sd8978.

Brian

> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
