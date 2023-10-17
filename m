Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F727CB9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjJQEO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:14:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F2E83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:14:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so5017835f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697516090; x=1698120890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2dZBUmwthCKe42eGQqfFVlklrGhflMnlew3Rp0hoTg=;
        b=Y4KfdR7BHSAD8ergWl9zJFZjW/kHu4yTFRsS9Hmo5lQ7ch0xtSpz5iP7CRHiK417Hd
         jzhFW/Bi2r05CVSx5PjLKo5KMRlR95fpTpuID5yXZONkC6BfFixackSCNCJb3ZTsx+Zb
         ldkmQrjUYpB4HZMR6eumiAOOa/pCEE6Vr8B/m5oyHzmFvXJws5nETbIPz4fz8FHBiU1m
         IQs0ibJoXB7+GioetWB6rKiqSNGNOfhTGOXJMf/T5F+ZFYU1lBPtocpaemKYgT+T5oM4
         wg/VLsM5HzEE3tEB3WvoVxePv+uk1eq85nwTmUNZhLZVF3LNn8I54QpLehriVhtRAnSb
         Z+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697516090; x=1698120890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2dZBUmwthCKe42eGQqfFVlklrGhflMnlew3Rp0hoTg=;
        b=gT7v79OD8lGwwqwikFvGMLpLeh1c6ARdjL/6hGHWblojSVX3rDUTzG+fap3REXKvIw
         EP5t+6zuVVp+7AD6pOYgxNkDdpi12Mniwlqja6njoT5ScgFS/NQZHwXHX9Wjz57WBZiD
         BTm1c8a9lVQop1a6UP5svCRlOsXkIwK3vykmfO8MjBKyo3utdXf5X1ljn+oVYsv5JXgR
         iuOvmonAFIUYOOplt8a4kxraKbMTBgOSq6Q3ReDdXM5+ZC+nDjXswSPu3/IzSnv6V0U4
         LSpk+W5zaG+WYsuYBUe52l6AQaVcs6H28c2bX6BLhZSzPQmCD2l5ve5raesNLgfXY+Nn
         rgug==
X-Gm-Message-State: AOJu0YyCOPj5DvIrj1vj1gItKQMTwx748EAdzTmdAw7+n2Rd+9b8zFjk
        aqonhtb2CAg8q7rdLYUk1ISb+g==
X-Google-Smtp-Source: AGHT+IHL9edRjCBjUElxLPuvZjX09mIVD7SQA1z7VlWAEUiuE41FNpxgzfuMp4mLH2kzKjjH4uH/0Q==
X-Received: by 2002:a5d:6186:0:b0:32d:9d3d:8b98 with SMTP id j6-20020a5d6186000000b0032d9d3d8b98mr1034563wru.71.1697516090540;
        Mon, 16 Oct 2023 21:14:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0032d9caeab0fsm686370wro.77.2023.10.16.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:14:50 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:14:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Remove unnecessary parentheses around
 condition tests
Message-ID: <8de0c0ea-d81c-402a-a5c4-7779a190c306@kadam.mountain>
References: <ZS0f+xaaLmLpKv2a@gilbert-PC>
 <2023101658-unmoral-survival-25cf@gregkh>
 <ZS2qpwnfCxsbvOld@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2qpwnfCxsbvOld@ashyti-mobl2.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:27:03PM +0200, Andi Shyti wrote:
> > > Fix 47 warnings detected by checkpatch.pl about unnecessary parenthesis
> > > around condition tests.
> > 
> > And as I have stated numerous times in the past, they are not
> > "unnecessary" at all, and provide a valuable hint to the developer as to
> > what is the ordering involved.
> > 
> > So you can ignore this checkpatch warning please, it's not valid as far
> > as I'm concerned for the subsystems that I maintain in the kernel.
> 
> I find this very confusing, though:
> 
>    if (((ep->epnum == 0) || (data & (1 << ep->epnum)) == 0))

Yeah.  Too many parens.  It could hide an == vs = bug.  (That happened
once 10 years ago but I still remember it as if it were a useful and
dangerous anti-pattern to remember instead of a getting hit by a meteor
type thing that will never happen again).

Also == 0 should only be used for the number zero (used as a number and
not as a logical no or absence) and for strcmp() functions.

	if ((ep->epnum == 0) || !(data & (1 << ep->epnum)))

regards,
dan carpenter
