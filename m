Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09E76F911
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjHDEmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHDEm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:42:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664AF2708
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 21:42:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc3bec2c95so12216425ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 21:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691124143; x=1691728943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WhhAvXcLPp41DDPWdXv76vCKorVBoPGcJuLdcgKOZzY=;
        b=CWLQdtDXWwvZv34z39X116TeBtMFjBj5iQAdzIO7mlp3mKO0CHIbDYIzlkYedweBR1
         +EVBj5HVLAUC3BP8R46xItOnAbJYAgrQPgJRdlEkZvZfSN+H3hc/tTMrOLkJy3dcggWW
         ZmjzHd7E9fqfFrdesEcRGKb2hGQV3Dg0KIQWMzCGnnye4k3gpZLLx1EhM27r3VnNe+k2
         mobIjWeZ6vTfSUpmq7zNN/wZsSj7+KIhf2K9vPnW2LHuf/SNjpLXfYGl8k232yRGrHWT
         3WBVct2i2L3bXeEEMeY2phT3NLQvayBmS4cPazsUgqLBctQAEp/0eGwoUUftFAN2MHQZ
         8pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691124143; x=1691728943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhhAvXcLPp41DDPWdXv76vCKorVBoPGcJuLdcgKOZzY=;
        b=WwgYHewNgLc8F3C8hE1k0P1As69FafLJgIZzJVLGhOKUdV53mpvckfRydoGcklxkga
         QS3kH7D1eCm089A48Rjw7d80HhVQPXSKigaHRTwaqJpV8qWdWnH5T3wGto1m1Q01iH+t
         Zn5CB3CYXt5XJb+iYIB+hlcomP6b9m5uqjtdY7C6CZJJZcjzv+VH9yrJJkOK/5IPH49X
         8Pm9Yo/Yj7lnh46Nc753jN8JJYX89iqt227n80aCk/TscY80cNoHYbhDASDWAZ7nmy8j
         +qtP+ZJ9lGRSaynYruRqOjM98VAEoDWiVxitX/yBmArsD9cDt0tEtpYyAC/K2Ry4wcO5
         9+3A==
X-Gm-Message-State: AOJu0YzoboLTNyIAUFcfWLNExkdeVhPf19j51wilTwRbZw2hk2vmKaX1
        CtWzf+j6Lmw5JW4UK634VgRpWQ==
X-Google-Smtp-Source: AGHT+IHVStLeBwE0WuFzAlxE5M1adCY0bQ4JoZ/lSAvfsGjyMlxW760cSktFwB69LZ5NsgOcqkIsxA==
X-Received: by 2002:a17:902:e886:b0:1b8:3936:7b64 with SMTP id w6-20020a170902e88600b001b839367b64mr1071513plg.1.1691124142814;
        Thu, 03 Aug 2023 21:42:22 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b001b5640a8878sm676697pll.180.2023.08.03.21.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:42:22 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:12:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20230804044219.ng26jwcomprguoi3@vireshk-i7>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
 <20230801093620.ggz25g3faxycp44q@vireshk-i7>
 <CABN1KC+4kznd54-dZf4PiftxiqBfkGxpsqngaX4=dGf1pNg5Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABN1KC+4kznd54-dZf4PiftxiqBfkGxpsqngaX4=dGf1pNg5Ug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-08-23, 09:50, David Dai wrote:
> > Why do you want to use this and not module_init() ? Then you can
> > simply use `module_platform_driver()`.
> 
> We found that using postcore_init over module_init results in a
> small(2-3%) but measurable benefit during boot time for VMs, so this
> is an optimization that I’d prefer to keep.

Okay. That's what platforms normally do (kick in cpufreq support
earlier), so we can boot at a higher frequency. Just wasn't sure if it
matters for this driver too.

-- 
viresh
