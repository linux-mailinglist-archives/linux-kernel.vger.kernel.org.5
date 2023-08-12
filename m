Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16077A305
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 23:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjHLVN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHLVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 17:13:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B217B198B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:13:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so4037451a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691874839; x=1692479639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qN4+JPQ2uMhH474HegNnWcROGyA8dAp5RWQJWrAdXg=;
        b=gFgNBX8i2ETarPsMHY5Nwpour5KM7lxMnTS87CWAozeTybwQL9q2Rb3kTOnNRI97j+
         r/i//H2etz35n45IOeq6yt534e2jH2A44yH+8/sru3i64/uOzJYDWo5ADHM51OMvUuiW
         5z6AIkEj2il96lkFKvQxYqvk4GNv5EFMm7pwKINEShREVSMQlad+4h54SjA9CRwt0iKM
         YaIdFYdISI5qJZOAY0FDLGouscOt5FxryP+tuSa7Rh4kFZxZqV4m83k9KGu/bI+OAvOr
         7GCAj1N1mAOVYWytrqzBqDUvPMY6QnLBmpbLLQBykvub8CYMliJJ0McWg7+bzS+OoQFK
         11/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691874839; x=1692479639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qN4+JPQ2uMhH474HegNnWcROGyA8dAp5RWQJWrAdXg=;
        b=Jzets5O0tRP/OyKBwBOXQVlG3RlZdpgr0VYzzeLLq686/lcCXkXnhJoPu4US0oV3Ui
         tDSc7Ec8C5VOA14Yu1ptKC1NWut/51vY7VS3Bu67NiWRD47LpJ9EV535LG78bSB3qmPn
         oO2Gz+c4EV6gihRGIscqiFGfQox4pSiLJjV+gTjE2RizW00Q+NUnlTlYIZLZOfKvYCvX
         P0WTUGNi0XgllYCzJVlRse9WofFso/y2II/UTJRpGGVbpxLiNP050garr9BRqxTLwwo6
         I/xirhT8KaetS5PRqo6wrJoUkytaTwK8KnJlxqbtyj8qoSre2lomG85X56Qrib0IRRE7
         T90Q==
X-Gm-Message-State: AOJu0YyMQd6d99W2JDMBoAJjEejmYKTzex5hAvVib6CRrUbdZhWKypX6
        X+3QUtHi58p53Mr1Q8P4vttqwcfz5k2D1w==
X-Google-Smtp-Source: AGHT+IH1wsb9qoAkdoUo98/0EkE5TmD0l13LQU66xkUbR5ROmc684BH2TKxF6ywCJFe7fWDIVYRQMg==
X-Received: by 2002:a05:6402:1b06:b0:522:1956:a291 with SMTP id by6-20020a0564021b0600b005221956a291mr4407137edb.8.1691874838601;
        Sat, 12 Aug 2023 14:13:58 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id c23-20020a056402121700b00523653295f9sm3648305edw.94.2023.08.12.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 14:13:58 -0700 (PDT)
Date:   Sat, 12 Aug 2023 23:13:56 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Staging: rtl8192e: Rename struct rx_ts_record
 references
Message-ID: <ZNf2FJNPF6A4jwcX@nam-dell>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812201702.83421-1-tdavies@darkphysics.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 01:16:46PM -0700, Tree Davies wrote:
> This patch series fixes checkpatch warning Avoid CamelCase, for all references
> of struct rx_ts_record, and renames them to rx_ts for consistency and 
> readability. Each patch renames references for a single function.
> 
> Thank you in advance to the reviewers
> ~ Tree 
> 
> Tree Davies (16):

Here it says there are 16 patches, but you have only sent 6 patches. Are some
of them missing?

Best regards,
Nam

