Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B250759D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGSSfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjGSSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:35:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A71FD8;
        Wed, 19 Jul 2023 11:35:03 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a412653335so4552137b6e.1;
        Wed, 19 Jul 2023 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689791703; x=1690396503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+qQ3BjPeMCjsqB995zYt9EkRiHcQsVLDEmosf3ZMog=;
        b=LN0HmCIzcXn3sByOkWlTBnx5yH9j1RxPOX5NGUJBc9dxhdlcKtVanGAvtuMLSos1TA
         ShxskVfUzCg3bxDte5q/KvVGlkq07kLCxOnRY6olWDdqwgGgNGOLEArz53wkw+sUPboO
         j4fbgrlbdWunoAFvGIjXxY3rRGDTPrm9Kb9iquVi6R+qrV+JywV2P1eCZQ3JmX4rLCoq
         LjTr3X2/B21yXe4ohJudgQLo1+ret3gGr0irH77AWiLvpWygRc5g8KEQQ+qsujxnbrEJ
         SEnHqckheqSwwRIq+4JNgq2HcNXHqziKxEXpjlrTuGKKaMuKfHjFC/p6Je/HAMuZ6WNf
         r1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791703; x=1690396503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+qQ3BjPeMCjsqB995zYt9EkRiHcQsVLDEmosf3ZMog=;
        b=LTVV9LOIlBZ5wx3BbVsBIZgSnHzSoWwRdhxQcTq9I69sFxTn6bvjo+gc21O7S3fgT3
         BUXqoRews5U5p+bffiu5aO8qCqZhYL4hXf2X8BTLQR+jGIuiVDTdW3RRR9odSVmsr9Ax
         sBAoDlhZqbIr7T77kAysramOdSh6INASxmH4AuyMvohNMex6R4W5GJfOpPUB4Mf9HRNo
         P2q/m4qGIwm/QTSVs6nPQIdYj9l2crAewOvEMr0i/GLO2gaEFeglz6Un56OLV7Ua+JZ6
         juRS1sAttyDq3c3j689ahZ9hs63Pb0vtqmyV9Sw7TuLQpCaGd95BBwwtJe9UwhmB9nFW
         vlvA==
X-Gm-Message-State: ABy/qLbtNmz7A6huYzcZj+jvb35cE4qjraGbsRjtimxjmfY70ORq+W8P
        YBILNVXsDFhaBiFx18ghi9g=
X-Google-Smtp-Source: APBJJlEn820xR4AoWzwfa2FqlCl0yuA51WnHWC1cvNGUIEWo2uUgwQ79thqMIEHL6ajtgA6b+k5PGQ==
X-Received: by 2002:a54:4596:0:b0:3a3:6f96:f15f with SMTP id z22-20020a544596000000b003a36f96f15fmr3079701oib.15.1689791702954;
        Wed, 19 Jul 2023 11:35:02 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y7-20020a056808130700b003a3860b375esm2042016oiv.34.2023.07.19.11.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 11:35:02 -0700 (PDT)
Message-ID: <919dd69a-0927-129b-a913-2acaf2eaf4b9@gmail.com>
Date:   Wed, 19 Jul 2023 14:39:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: rust: update instructions for obtaining 'core'
 source
Content-Language: en-US
To:     Trevor Gross <tmgross@umich.edu>, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230718054416.861412-1-tmgross@umich.edu>
 <20230718054416.861412-2-tmgross@umich.edu>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230718054416.861412-2-tmgross@umich.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 02:44, Trevor Gross wrote:
> The source for Rust's 'core' library is needed to build the kernel with
> Rust support. This must be obtained manually when using a non-rustup
> install, such as when using 'rustc' from a package manager or from a
> standalone installer. Currently, the documentation suggests cloning the
> 'rust' repository to obtain these sources, but this is quite slow (on
> the order of a few minutes).
> 
> This patch changes this documentation to suggest using the source
> tarball instead, which includes only needed information (<5M) and is
> significantly faster to download. This is more in line with what
> 'rustup' does.
> 
> Signed-off-by: Trevor Gross <tmgross@umich.edu>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
