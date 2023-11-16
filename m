Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8139E7EE50F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjKPQW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjKPQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:22:55 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79252189;
        Thu, 16 Nov 2023 08:22:52 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5875c300becso558346eaf.0;
        Thu, 16 Nov 2023 08:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700151772; x=1700756572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs8icm+iMMidy4R85L/9ZGbmCFlh9//SffKirAVv9pQ=;
        b=BkVVVDhVU0yOLcdoM8XbCtYBZE63WSqRBfyCc0fzYZqxT4bNJVcuQvgMxr0sZK+Cj0
         6/l+tZkhrGQikjxsAm+0M6CCFxzpHnh7ePBjwS1bTCNg68i3JBMCGAS7Yq6V6N5hvw5L
         LU9+kdaVgEklRv4GCCN+up4Cu9/s7kkovz1Y15hqFSOkP5lMUVfu52OHi8tD25+x6Sws
         QS9jaldNDkN14VifA49R2VHwA55YwAjTcV/CVPbWpWBjQ5Pl1ypr5gPOD28lh34es1ij
         me4SGeAVkWni5GqX9ja1iIvxFA+S1wpmXA5g2axroEi5tmqML08t9ZHQjc/a5ROwBxlS
         aBVA==
X-Gm-Message-State: AOJu0YwuC859e7j8xUBnQ7xJMasgbBgBGgnTIx/pYihUJ5huhnDWdbjt
        ToFh+FtOzvaKBTTqvDEhUg==
X-Google-Smtp-Source: AGHT+IFnKbCB5st7hQU+OKvwZLFiA+nmISbSf/raMUvn3R7EMCMOsFN+4Xt1evr/F2ThXJZzS1wIIw==
X-Received: by 2002:a4a:3443:0:b0:581:40d0:7166 with SMTP id n3-20020a4a3443000000b0058140d07166mr16693216oof.8.1700151767156;
        Thu, 16 Nov 2023 08:22:47 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c1-20020a4aacc1000000b0058a1d87d96csm1088314oon.41.2023.11.16.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:22:46 -0800 (PST)
Received: (nullmailer pid 2431114 invoked by uid 1000);
        Thu, 16 Nov 2023 16:22:45 -0000
Date:   Thu, 16 Nov 2023 10:22:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <20231116162245.GA2424810-robh@kernel.org>
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-2-davidai@google.com>
 <20231115062741.v3tpm337c2lidxzr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115062741.v3tpm337c2lidxzr@vireshk-i7>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:57:41AM +0530, Viresh Kumar wrote:
> On 10-11-23, 17:49, David Dai wrote:
> > diff --git a/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
> > +$id: http://devicetree.org/schemas/cpufreq/qemu,cpufreq-virtual.yaml#
> > +properties:
> > +  compatible:
> > +    const: qemu,virtual-cpufreq
> 
> Not sure why we need to mention QEMU here.. Why limit this to just QEMU ?

Because that is the implementation. And also to discourage anyone from 
using this on their hardware or thinking it is generic and the way to 
extend it to another implementation is adding properties.

Rob
