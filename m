Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B08D7E31FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjKGAG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:06:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBEB1BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:06:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc1e1e74beso46253655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 16:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315611; x=1699920411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3lHltmHAT3Zjs2Or9HI9VhRMd3mEFK2uKST2wN2rlk=;
        b=BBv9tJ05TyDM6ruq5aLaQG6bBpSjbAi22255S4eTkR3+Wt6CCj6eLdFORVXaj4cAIS
         e8Qp6m2gtuaiKUBIurLBSJ8m1k95L24J0an7pbMqNr8aAk8yj1MsUaedccNQ8NbexXPX
         DbG9xbQzCBsAgdjSupa4nzqhER4PMH0zyur0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315611; x=1699920411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3lHltmHAT3Zjs2Or9HI9VhRMd3mEFK2uKST2wN2rlk=;
        b=wL07tPpAL0PuvGzR9VT6UbOaQP/CKpURKN2RceWJXIfUsUGFaft5Oj6C2RnPKHu3o1
         evDDA6KKgO49+Wzam2fsQ4OnFEBwsB9hkPz3hVNiMuIERJ6YhUvvWIMdwr7DcO2WaNXK
         IzD5jqP4kbyajVhJMlkr8WcU7nAphy2DpGd/JUi10HnsnuwsVXrrIH9H3jVDc4k6d/se
         P5bVcLAcbC71QvU1wFcuULqxzmVgnPDp6bUfS7zt+vlCYhWduZnl2YcIN6QQJk/+r3Ev
         xjwPPxBIJDOkUHaVRWbIi2LbCA8sE3S3A/5w1wChFDOb6P6tVjH5JiAEXbNXVXCJj2zu
         v+sg==
X-Gm-Message-State: AOJu0Yw0zztcZhdcpq9yPqHDOGxxT8oi265xyXv3Mv2ilrLPY/QwdMfU
        yoAw6LYW3oEVWfk0VKc2YP1U+A==
X-Google-Smtp-Source: AGHT+IE9z6AcBHk9ED2kB1KouwueOG1tOWlEHOZOuaUzdUabyJxe5oUCUNA4++KR+8Vk6f8c04Ot/w==
X-Received: by 2002:a17:903:2594:b0:1c6:117b:7086 with SMTP id jb20-20020a170903259400b001c6117b7086mr27742336plb.5.1699315610900;
        Mon, 06 Nov 2023 16:06:50 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001ca82a4a9c8sm6307809plt.269.2023.11.06.16.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:06:50 -0800 (PST)
Date:   Mon, 6 Nov 2023 16:06:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Fix multiple -Warray-bounds warnings
Message-ID: <202311061606.29DB1C09@keescook>
References: <ZUldRv35EXKHAt3L@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUldRv35EXKHAt3L@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 03:40:22PM -0600, Gustavo A. R. Silva wrote:
> Transform zero-length array `entries` into a proper flexible-array
> member in `struct journal_seq_blacklist_table`; and fix the following
> -Warray-bounds warnings:
> 
> fs/bcachefs/journal_seq_blacklist.c:148:26: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:150:30: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:154:27: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:176:27: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:177:27: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:297:34: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:298:34: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:300:31: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks; that looks right to me.

-Kees

-- 
Kees Cook
