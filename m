Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31E808823
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379337AbjLGMoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjLGMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:44:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4CD5C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:44:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c2718a768so9337415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701953062; x=1702557862; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsE8VKSbmAi+XCUf7rJv0gnWrUVEmUsv4rH9rY5pctA=;
        b=gS0F9CoGehLZx+t8NgrD6u2bop+kxz3vrXxyOlnwSK44XvjRQmb5X5Igvq+RkGf7ld
         zotNuFan722MfrKK0gDuE2pd9/0MwTq+BYaX77TY3YV98G3179EJ5/yW0ha5nzFMcdqm
         RYjNhXgaCodiOb/tyEuHD4E5eJxvaPcc6KgKgYyyHgg1F/DPuIL2qUJZ/m6KbX8Lo1/o
         IXfTFAEYr4NYflJ6ByJtD2+c5PnrEKMdmfTHCmVynAoL7pMZRT0mOqCXqq0FiJkDiq7e
         AYYYOf2gKTtPSxf8SZZnUsCuW9ozCRJTtrvmWd3r2x10UtLHEYiZ9Ssmycc/KC8uJJQx
         wlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953062; x=1702557862;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsE8VKSbmAi+XCUf7rJv0gnWrUVEmUsv4rH9rY5pctA=;
        b=ourmN/sFnN7yvJMNyZ7pGwDO1zWUsHyjJTTFa/ZGi3rx2qE9skDKqM6bk1IatX1TZh
         rqcRnB1WLzjHn1tPvht7pYyqM95EMLZR1gUpYQlZEyShmWtki+7O2g6Afr/qOG4Af4B2
         dBEwtLek0UwZDl2xX9n8lJtBVyCarJu6gnHCaOpzkWGk9DkgpfR66OwinR2etqwgP2Gi
         I8S9UwxdTdNeQJkwave+3fzM8MEwGZLPg7jBd/MRwIBJpn22xdO9nQnPATp0H8sjHQrf
         +ZMqHlhV6IQAjktz2O3vAPEImaIY1pOP9OvJJnRmkHMVb2JX46Nr6oHuFrGUEOTXGymH
         UrWw==
X-Gm-Message-State: AOJu0YwJk7ybXTzLzACz5cVwt0cJN8Lq7RZkTmoozEYW8eqTEr7Sfps2
        PX7jJa82IHYT7urupvkWnwUlpz6GLa2aCjRIdn8F0A==
X-Google-Smtp-Source: AGHT+IH0bdOVfz7f3tCZzVLnygI36YPXIwbVzYnykMM8nZfSU0jI0uQOTzmslWb2tU3WnJlf3MiVMQ==
X-Received: by 2002:a05:600c:4512:b0:40b:5e1b:54a3 with SMTP id t18-20020a05600c451200b0040b5e1b54a3mr1575292wmo.47.1701953061849;
        Thu, 07 Dec 2023 04:44:21 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id w2-20020adfec42000000b0033342f72bf8sm1372820wrn.9.2023.12.07.04.44.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 04:44:21 -0800 (PST)
From:   Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date:   Thu, 7 Dec 2023 13:44:22 +0100 (CET)
To:     Benjamin Tissoires <bentiss@kernel.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/hid: fix failing tablet button tests
In-Reply-To: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
Message-ID: <nycvar.YFH.7.76.2312071344050.29220@cbobk.fhfr.pm>
References: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023, Benjamin Tissoires wrote:

> An overlook from commit 74452d6329be ("selftests/hid: tablets: add
> variants of states with buttons"), where I don't use the Enum...
> 
> Fixes: 74452d6329be ("selftests/hid: tablets: add variants of states with buttons")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs

