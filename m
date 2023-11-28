Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB07FB14C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjK1Fep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjK1Fen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:34:43 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C84DA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf7a8ab047so38876605ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701149689; x=1701754489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLD4U1IQ3GBXZUYRBdNM3XjIajDHuVM3KMdSWM11Qn4=;
        b=Hndy02yttaR7uPciKF4mqyxHp/ZzphH50Pn8hswI1nmCCmMRiACwdOOxOCtKxpzAEm
         rvFD7mswAZUI9zITOhIQyqdG2ChpV+lnvWbnkm1jLevUdOntKSO8G629xXhHayTJ1jfK
         3Uei5bjNJ4tTfNr6zirGydojqZaAb7dnWkjpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149689; x=1701754489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLD4U1IQ3GBXZUYRBdNM3XjIajDHuVM3KMdSWM11Qn4=;
        b=Vy63bPmm+GyuVYy7xnsq/C4+AB6+31wnv3uBSZjF5EelVqwbxWHYg3F86rbrr8lh4/
         yPJSXy3BOhM1TxYsYwP4I+/Df/FcHycvkhoP6Ijoy6S6E8yoR6pTonJABsLJhPwsbbth
         u3bHgSK/yjq3WYSMmqPcyaTs05u70NTizib4IK/6Vk2EwGVoDpAF+ta7gG3HQE75Cjoe
         tKoKJqkxqQzt/IpEDO2bktmzlbsL3QeEnyg5YaShQy5rJyOUDRz9001xGmYKNKu3Euq+
         msGj8lKppoyqAK2Sy+DxcyDd3wqspNjG1v1h2VrLJa4St2ICU8p3u4Wgrc4MABqUOgJc
         96OQ==
X-Gm-Message-State: AOJu0YzrU7T3eOPDilvOvakRFqqaEj/xqpnFahI05DUmkOmu1p8YJxeZ
        1HL6K8S2TyBSOARZudyVafLV9A==
X-Google-Smtp-Source: AGHT+IG9oo9og7X0ZOa7sH8woREQOsxuAEQf7/f2lcKOZ5d71WwjwmAbp9twRvlp1eqdZVSNGAhVTQ==
X-Received: by 2002:a17:902:9a96:b0:1cf:b4ca:4e79 with SMTP id w22-20020a1709029a9600b001cfb4ca4e79mr6869880plp.17.1701149688975;
        Mon, 27 Nov 2023 21:34:48 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001cc29b5a2aesm9280184plk.254.2023.11.27.21.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:34:48 -0800 (PST)
Date:   Tue, 28 Nov 2023 14:34:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Patrick Georgi <pgeorgi@google.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Reinauer <reinauer@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] kconfig: WERROR unmet symbol dependency
Message-ID: <20231128053443.GA6525@google.com>
References: <20231122034753.1446513-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122034753.1446513-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/22 12:47), Sergey Senozhatsky wrote:
> When KCONFIG_WERROR env variable is set treat unmet direct
> symbol dependency as a terminal condition (error).
> 
> Suggested-by: Stefan Reinauer <reinauer@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Gentle ping.
