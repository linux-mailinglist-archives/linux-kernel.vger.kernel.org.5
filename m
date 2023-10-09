Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DE27BE91A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377577AbjJISTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377544AbjJISS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:18:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142EE9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:18:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso4323972b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696875534; x=1697480334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDDwHA1/FuRqkQTdU8IROnl1mr9DrFny1zyzcov0LMY=;
        b=nN/D6HxLLq0wBjMwZchBf6jcqQZ50K0vCeZq89frTuD/8Yaas92udKovcsUkTcFKxb
         FDdX7hdWniE2j9UO0HrL2QvfUqbS3ZziGsa694uAKk+he0XA9FjQBmSPcCzJDXmy6fv9
         3vOM46JIUMBI9cVKsohn/lYppRUsBi/qBSVQqAhes4iyNqgnFS4LKIrvll5worIPKB82
         5II7rbGCQNZ9lu5lByUyvKVOjBQ3wxUs617yKA7fOBUgXdpMeBCfWM4lW6whok+8Npg6
         P/W9v9tsE2rIS62C+ABF1vP9NTllsJyfliPQ+GG0QS3DEj4l+/oStUqaELspmwcinRtj
         atMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875534; x=1697480334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDDwHA1/FuRqkQTdU8IROnl1mr9DrFny1zyzcov0LMY=;
        b=eIpcAwtBOjHM2PMzDuL/0ehRex9S/xmnelGSWa4qtZPCKOw6xpaa3gnnGHrLuRGml9
         PdHpAb9B0FZv5xQzUksG4v78bu3mjcaqKTciKAtBbxZG0/YSmIQ/dQagZxvr+fw6UIVk
         zvafN0W2oT5xnB0h5GmuBQB/X0QAfyLiibPS23do+KTYFQPD2kNghz74UyoLqhIRJyMz
         oy0oHnl3oAPyfuYtC41GCjihO9zE0qIR7B56VKuwWcKUimmgmYL8aTks3n3865ivCfi0
         RIcf6dqaNxIn7kwnGCOdi5cTeMB4C5A94xJe/zMDVXu4jra3oQdS7Fl3oQ73bINUfU7w
         dDyw==
X-Gm-Message-State: AOJu0YySxYn7pYpOa6uELQYS6FLPh9lpSzNbqlYXdLFG7AUHamcVpCKs
        j54VyHzEC8DWnb5ZzV9Gl9U=
X-Google-Smtp-Source: AGHT+IFAzE+cWNVHP1L6iYzhdJE/FEDRWIqnwfEddam+sluH1nPouDojfYDigbrDg26BP0BD7EofkQ==
X-Received: by 2002:a05:6a20:7488:b0:161:2607:d815 with SMTP id p8-20020a056a20748800b001612607d815mr19051335pzd.24.1696875534485;
        Mon, 09 Oct 2023 11:18:54 -0700 (PDT)
Received: from swarup-virtual-machine ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b00565e96d9874sm7673833pgf.89.2023.10.09.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:18:54 -0700 (PDT)
Date:   Mon, 9 Oct 2023 23:48:49 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com
Subject: Re: + selftests-proc-add-proc-pid-statm-output-validation.patch
 added to mm-nonmm-unstable branch
Message-ID: <ZSRECdGdkFjoMbz2@swarup-virtual-machine>
References: <20231004201701.87CB5C433C7@smtp.kernel.org>
 <9ce82fc2-4e09-40c4-b5a5-a9a049c2f493@p183>
 <f50cfce5-5e46-433f-be48-a8c733843457@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f50cfce5-5e46-433f-be48-a8c733843457@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

esOn Mon, Oct 09, 2023 at 12:00:04PM +0300, Alexey Dobriyan wrote:
> On Mon, Oct 09, 2023 at 09:14:53AM +0300, Alexey Dobriyan wrote:
> > On Wed, Oct 04, 2023 at 01:17:00PM -0700, Andrew Morton wrote:
> 
> > > +		if (errno == ENOENT) {
> > > +			/*
> > > +			 * /proc/${pid}/statm is under CONFIG_PROC_PAGE_MONITOR,
> > > +			 * it doesn't necessarily exist.
> 
> Oh, and /proc/*/statm is _not_ under CONFIG_PROC_PAGE_MONITOR,
> it always exists.

Hi Alexey Dobriyan,
It is my mistake, i checked the code, yes it always exists.
Thanks,
Swarup
