Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186057E613A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjKHXzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:55:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE3B2686
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:55:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so261281b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 15:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699487705; x=1700092505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Zj6aiYPItnuW/II6rnVjTEgzD4cCUTmx7jt9HMfXA=;
        b=FEPZw8Jhw5EDWq1LtOTYiwL3+l/Fc/leSau8qVX6MxAosWhTLSU9XomEN8k0gGJrkD
         bd5OpBXKfBQQdxV33FNnzfj9xOL2WXUvA8dZllvRWjoB2HpK3ZYwrM7rQ59Jr0RoPYva
         sM8FOyP6O8HGditWkZX9RCrZCIiZfCt67yFqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487705; x=1700092505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9Zj6aiYPItnuW/II6rnVjTEgzD4cCUTmx7jt9HMfXA=;
        b=qBLfsKPs5iGLmKxYPO/QaOETqrVFaqDgi/ScYr9umPW7JvTvoEe4hwFm1akAF2hjVZ
         cvCqx3opdUJQMrp3UyrsyBc05EQvtA2imfn47f4Ci9viuZZC4ymuvSlF8RhZxk1r6/dA
         vNI0Ma2/fvJ5VuKnxFOYZ4y+usgHwFWT6DsyrbNzQhJQplkaPc3jwNXYVI7BzPHhwYaA
         cLt8B0XZRScQcQklo/ejfMvSggoSegk1TkzUrPivXFQzJV6oQf3aPY8ps7fXzM3XTslA
         ybCbBPpdLaoWG2oX7yVRywE0+dJm8fHxOI4yTsHX1yijT7B33kISYwbCDB3MXyNGaM8U
         rurg==
X-Gm-Message-State: AOJu0Yy1/hRAbwzY1CbJ/ek8ObDnzy5izb31zSyEUeuwhOyDapg+4BU5
        WzY/jTbev+qtSVzFHv6e0UNw5Rcso8y7EcMO55gj5A==
X-Google-Smtp-Source: AGHT+IG/qaDCcej89YQMoQMv/HF3e5O7ROLDD78dWthl3PM34DsDAfNZV3iFa4+MyubwH0R/Ie9e3Q==
X-Received: by 2002:a05:6a00:1397:b0:6be:1f19:e604 with SMTP id t23-20020a056a00139700b006be1f19e604mr3874872pfg.21.1699487705464;
        Wed, 08 Nov 2023 15:55:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a056a00234600b0068ffd56f705sm9413130pfj.118.2023.11.08.15.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 15:55:04 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Runov <runebone1@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typo (args -> argc) in plugin description
Date:   Wed,  8 Nov 2023 15:54:59 -0800
Message-Id: <169948769743.634942.16140786169339944905.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030094508.245432-1-runebone1@gmail.com>
References: <20231030094508.245432-1-runebone1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 12:45:08 +0300, Konstantin Runov wrote:
> Clearly, argc should be used
> 
> 

Applied to for-next/hardening, thanks!

[1/1] Fixed typo (args -> argc) in plugin description
      https://git.kernel.org/kees/c/b98cf399839e

Take care,

-- 
Kees Cook

