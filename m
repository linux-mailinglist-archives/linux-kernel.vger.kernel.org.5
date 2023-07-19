Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34F759A57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGSP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjGSP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:59:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC810D4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:59:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso65889215e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689782371; x=1690387171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsL4pIjQAoG5N+TFvgKqcjrLnL/JjQ5VBlWwNh3BthE=;
        b=DnIB1znTysnJ6MVo3jBaswdaO1pY76+dQHXANOdTFdUfam32T9nlFvL73B1EnyDyla
         fq1dd85jbOzT9eK6202aL85ERXAEmSfm3DHp9bZIzv3maJbbFC8oUQvcE790o5SQa0pm
         92+0k9K/MMsQBNpuzCQC+hoghbUzMW9Fbdxzkp/wM8FbB8FfBiUSkz0rMMwK5heyMQAY
         6K01olcnOs12RupMxpKqYTDvVh/M/YRGaM1kOpxR0Q+9wAZbW8OV5mXTJfzInv2sM1E0
         gEoG2TSaEdxYWylSLkJ73qRRjZ/NZ/FWAN5RL9RLlszudrmRGUgpCpdZ7AF+8mvoWPie
         d6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782371; x=1690387171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsL4pIjQAoG5N+TFvgKqcjrLnL/JjQ5VBlWwNh3BthE=;
        b=BOOg94gdimV564m2FZVZwP0tk1S1fWAiLSuDY3/EXHLVVrjkKvRpP2n2xP6WCnUvNI
         4jgFceKd8vUSOYf4hl8Z/C8mm4npP84zmDXbHc7Qudz10y9vQgR3nBr6/HmnKBhh8DYV
         EiawJwuI50RM5G0OM5v/QTXt4hH3u2LobQoEUIId6ZhfYn7BxI2riQ7tJBOxfoCoI1T/
         OMkhB+FJQeUk6lPZFAHZieAlBCsbBT4NQtRnP62XHbrcUX9/LHlSrzZKuefFt8+nwfvx
         pxzZz7v+A9W26UG6MxNG/DHB6QFfx7qJSTRQC01p2cTRatmQ5G3Vet8pFtwGYfSG0ly2
         JtHQ==
X-Gm-Message-State: ABy/qLYkXX+vRThasq96aKfB4RocTiRars64UQQO12lScUXnEviw43Ep
        HCb1pnVYU+bl74k2vNX5ADoJFg==
X-Google-Smtp-Source: APBJJlF1lqVzifTa46fV95xHgtqQnpTh6uXULNZMPtL7TNwHZ9MK7RNGBT6FEGR38DnSbd+QXWqVTQ==
X-Received: by 2002:a1c:4c15:0:b0:3fb:f926:4937 with SMTP id z21-20020a1c4c15000000b003fbf9264937mr2141539wmf.31.1689782371157;
        Wed, 19 Jul 2023 08:59:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe945000000b0031434cebcd8sm5713182wrn.33.2023.07.19.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:59:28 -0700 (PDT)
Date:   Wed, 19 Jul 2023 18:59:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     joeyli <jlee@suse.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Chun-Yi Lee <joeyli.kernel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <1acb2d81-0406-408d-b0df-73d1b1a4a9e8@kadam.mountain>
References: <20230718034337.23502-1-jlee@suse.com>
 <41f91e8e-8038-22d8-baa6-91f98afe405d@molgen.mpg.de>
 <20230719153833.GH14791@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719153833.GH14791@linux-l9pv.suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You know how when people are forwarding a patch from someone else it
adds a From: as the first line in the body of the email?  You could set
your From to the @suse.com address that way.

This is sometimes done in companies where the corporate email server
mangles patches so they have to use an outside server.

regards,
dan carpenter

