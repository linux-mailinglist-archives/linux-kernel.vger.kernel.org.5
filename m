Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9617D93E4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbjJ0JiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0JiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:38:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD121A7;
        Fri, 27 Oct 2023 02:38:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so296323266b.3;
        Fri, 27 Oct 2023 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698399497; x=1699004297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hp6XVPEWlKxTXMoDywd4XYa7dN3u7ZNoCSpHDxvreZE=;
        b=Qit7hqTQ6HauPP6x6/m0Z/Y62H3EWUAHgKHf/IcUQ+Rg6P2gAMdlRJnpYtG8bqWNv3
         eckxhpJuJ+2LBglAEuiMP7SsecmtSdFg8rsRaqx5hIYl+n89MxFyz4AqYyJxcaOMXQPI
         PhWiQALEbY3qSCvaSnxkZdZaHxlZ5q+EFyTF5+8q9MzrAw7V9xMUh5+h1dHv2DQkE0Me
         S2yoLiAnzJkmIRzHyD7F2lpBJrP8hLtifi1GHAi2Muvz1LLbkw5/AysZeH4QRmFJxvzX
         c4OMzaHCn4AEc38nMoruY+vhw76SKpGZyRkVJ7w7vmD8SkXKBNUC3UO4I32QwzQtqAFt
         sC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399497; x=1699004297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp6XVPEWlKxTXMoDywd4XYa7dN3u7ZNoCSpHDxvreZE=;
        b=NXdD8+6q8ye2YwslKRGpDKJf+HG6PNfys9sALVfCRVx1LDHBQKmXbI5liQXNODIm7e
         8cpQv6Ruu2RffmtFCZtuRspD8/CTmVNXyJ5yI691M4+fajdJUwaTAYanxcLVMKsQ3MKE
         GRfSxTpg6D4orLozKyIfkQCNoyKozPXXhVXTfXTF0DDvH/Y4IcxKeGLPxg6b1P3fZUDy
         IPRsZtjSKvDIZEEGEivsIqEoYJed8rszYeemJ8yQAQ1maXE6frNKQ/8JVE6zDecJpv1I
         h4RKoH34Ys52KMJzogWUjd1Cd5Ec9WAE2QfN+Chl2RjASc65QRbMCLV5oMIX+dDUTpVT
         fGpg==
X-Gm-Message-State: AOJu0YzxxUhvIcVw+Row1cx5blzcW1+F52YUAtnf5U0gC1X3qLgUt96A
        59bcsYLXudcaXYU1wd2rDLc=
X-Google-Smtp-Source: AGHT+IHzI0aCMNXRuDnb9VuStbNsXJS6VV7XmwVgqv9jAK1lAjcDkw3Qxzt8OId7LnzFUt6r8UW18Q==
X-Received: by 2002:a17:907:3f20:b0:9be:e278:4d47 with SMTP id hq32-20020a1709073f2000b009bee2784d47mr1882058ejc.27.1698399496568;
        Fri, 27 Oct 2023 02:38:16 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id hb26-20020a170906b89a00b009ae3e6c342asm913477ejb.111.2023.10.27.02.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:38:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 27 Oct 2023 11:38:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v4 5/7] cpufreq/cppc: move and rename
 cppc_cpufreq_{perf_to_khz|khz_to_perf}
Message-ID: <ZTuFBeVIjA2hjbPh@gmail.com>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027080400.56703-6-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> +/* Look up the max frequency in DMI */
> +static u64 cppc_get_dmi_max_khz(void)
> +{
> +	u16 mhz = 0;
> +
> +	dmi_walk(cppc_find_dmi_mhz, &mhz);
> +
> +	/*
> +	 * Real stupid fallback value, just in case there is no
> +	 * actual value set.
> +	 */
> +	mhz = mhz ? mhz : 1;
> +
> +	return (1000 * mhz);

Nit, and I realize this is pre-existing code, but 'return' is a keyword, 
not a function, so the parentheses are not needed.

Thanks,

	Ingo
