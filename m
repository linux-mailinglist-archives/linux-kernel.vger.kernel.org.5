Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100BC7DF8AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjKBR0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjKBR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:26:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E7F196;
        Thu,  2 Nov 2023 10:26:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a62d4788so1503386e87.0;
        Thu, 02 Nov 2023 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698945986; x=1699550786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V81heOTLS2HyOq5jt+KISDCrtvnQ83UiMpmGosl+pi4=;
        b=i7VbXqtLUdwaEhJwkomf+ZOmPKfdUA82IQP/abP6p3lZdgum7MHQjYeVjxE1gIR0F6
         krxV54ROoCrMM5Nr+pbIF7K70ZVXhD2ZOM8c1wwTlyUQ/Vi2OYXnqGYUa3sqQAZxWxIr
         /6JokZBNOLoTxjzR+6uEPIVQ2GV1zE9Wu460KiAUrzU39d0VHZGnLOWwggmrOOEmYEQp
         6bmoTq8Ug81HTiaoAsYy9JKjFNeHmXm8Q0jR8gVkhNLwO2Fl0EB6CIUp8GT3h3WxzM8G
         ElEaRPDWTaJxEk3sTp02++EXun/4UCjuNQl0VcyUBnvQDOlBS5Hmq5zvYQhSfI3uWPvR
         nnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945986; x=1699550786;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V81heOTLS2HyOq5jt+KISDCrtvnQ83UiMpmGosl+pi4=;
        b=mAKr2I+niET+THtPqPGrokmDfZocjI81lDbd6ereLvZPTTJS5fiXR8RLBlTnzJqGI2
         Lh8AaH6YY3e37gYG72lbZZaJUGmQviwnBdJTtkv/OoTs0UfFShVeKHc9cE5GxkuNyVgH
         Q4W963ItiTa1Q757x9kv9926uft6VryM8fBgzcYFlUNk7kUxLOjSjlGbYzMOUYZBZeJ6
         IJD3pLUbcOY94G0dgoSMRs2MHI3WYNXazrQJOPTZvRCi9+/pPIjAyuWOB5TVlQUeWxPm
         yymfHK9xjz4SFdOLfZVeSJXBM+jA8uHS87OEpG0vltHJ2wjACoMWpmKnjY7e8DLhUFSk
         Lrnw==
X-Gm-Message-State: AOJu0Yx16rFlLew6dUTBeI2yw0c4Iv6IwzxsO1f1l9tTp18h8Ic0BvwO
        CfZV0XUwzHt7I5VkyMdswjo=
X-Google-Smtp-Source: AGHT+IH5G6xdJ9QfMm+C/seRUMl1TXnM1Z96Q3PmBOXwUmrPkxArbBY9UbLxdXKlSwyYGgIIhR2blQ==
X-Received: by 2002:ac2:5928:0:b0:507:984e:9f16 with SMTP id v8-20020ac25928000000b00507984e9f16mr14357907lfi.36.1698945985351;
        Thu, 02 Nov 2023 10:26:25 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe58d000000b0032dba85ea1bsm2964216wrm.75.2023.11.02.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:26:24 -0700 (PDT)
Message-ID: <6543dbc0.df0a0220.21766.ef29@mx.google.com>
X-Google-Original-Message-ID: <ZUPbvmgeDjHUSwC6@Ansuel-xps.>
Date:   Thu, 2 Nov 2023 18:26:22 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 2/3] PM / devfreq: Fix buffer overflow in trans_stat_show
References: <20231024183016.14648-1-ansuelsmth@gmail.com>
 <20231024183016.14648-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024183016.14648-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:30:15PM +0200, Christian Marangi wrote:
> Fix buffer overflow in trans_stat_show().
> 
> Convert simple snprintf to the more secure scnprintf with size of
> PAGE_SIZE.
> 
> Add condition checking if we are exceeding PAGE_SIZE and exit early from
> loop. Also add at the end a warning that we exceeded PAGE_SIZE and that
> stats is disabled.
> 
> Return -EFBIG in the case where we don't have enough space to write the
> full transition table.
> 
> Also document in the ABI that this function can return -EFBIG error.
> 
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218041
> Fixes: e552bbaf5b98 ("PM / devfreq: Add sysfs node for representing frequency transition information.")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Any news for this?

-- 
	Ansuel
