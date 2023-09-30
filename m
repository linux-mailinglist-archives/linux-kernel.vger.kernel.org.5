Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A77B43E4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 23:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjI3VSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 17:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjI3VSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 17:18:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E2DA;
        Sat, 30 Sep 2023 14:18:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2791d5f1a09so782653a91.1;
        Sat, 30 Sep 2023 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696108715; x=1696713515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORlujt6dXhiMpBUwuEG5U7ad/x8e5Zc0l4TROU3y/X0=;
        b=g5vmTLQDWg2MpUbaDcmZbuDmf5fivfn6lYRXr5LeUvzdxVkVCIfF66d+F/IfItUaG7
         0B0QzvlhmcJi0b2uEJ/QOGVxtXQ6VuaLHnanATD6mH2TIVomQKEo7yPSZCjs+2u1hWrM
         s40YqZMv+QXJj+AUtpZyN0sDPvL70spXCzxbx7WYJXXo+N9uVB/UNOHoz9OIisuAvv1L
         s8yG2b+2OoFNxAZ8r/WN2gyWSW1+P9k2CBx8ZEp8H7lfdndrNwC87hdaYaeTOpXK0AOS
         XsOvurbtLaYkPIOOg/u9Z/iPrBtp/UvhgAVfO8d0qJKCnwDT0QQyoppql9N4uPh5MAk5
         AMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696108715; x=1696713515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORlujt6dXhiMpBUwuEG5U7ad/x8e5Zc0l4TROU3y/X0=;
        b=NhuJUPxcdQ22hk0En7c2aIsblPO3oPoZ3ishojkudZMsBSViPAC7ILSr1U7Yifvz66
         AAogwSEIIS3TNjXq2nvl0XjRaUpoZZY44waJh4fgomikMC2PASZxvqJTIG/4lbSxc1Fl
         xKqt1tjzM4C/+CqUNWxPYlLXsOxZuXkvLMa2cQglrpPDfAYMki23VoO9n2Dh/fIT84xO
         RMJB4+ZmpJXx1noE81X7q+rIWjCMlNA2JSFdVdiUjcdKfWFm3anepvo9rZtZnoMci+PC
         2YpZ9uzYLuyBI2C5z3XjTnmcNmd9vcQvStA4jtQCszlTc3HOKqVGPkvavdJYyRbAg8nD
         FWlA==
X-Gm-Message-State: AOJu0YzYAlMQBDLr9WpSwv9KfB5ukOufXfcyL9HfEyrxWXuxW9Vj/pI4
        i/THNcxmh6JQVZKVXT34ebIU4FNBOss=
X-Google-Smtp-Source: AGHT+IHrh4tkXU3DzIj+v0qosimxEO0gKe4mpDVnacAvvk8GQTySPNQu7ysxHUn3/y5krRM1bdyVew==
X-Received: by 2002:a05:6a00:2a4:b0:692:afaf:32b4 with SMTP id q4-20020a056a0002a400b00692afaf32b4mr7469009pfs.0.1696108715211;
        Sat, 30 Sep 2023 14:18:35 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7859a000000b00690fdeb5c0dsm16889552pfn.2.2023.09.30.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:18:34 -0700 (PDT)
Date:   Sat, 30 Sep 2023 14:18:32 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Mahesh Bandewar <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCH 2/4] ptp: add ptp_gettimex64any() support
Message-ID: <ZRiQqLYpzJGbiqYX@hoboy.vegasvil.org>
References: <20230929023740.1611161-1-maheshb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929023740.1611161-1-maheshb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:37:40PM -0700, Mahesh Bandewar wrote:

> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 05cc35fc94ac..1f1e98966cff 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -69,6 +69,14 @@
>   */
>  #define PTP_PEROUT_V1_VALID_FLAGS	(0)
>  
> +enum ptp_ts_types {
> +	PTP_TS_CYCLES = 0,
> +	PTP_TS_REAL,
> +	PTP_TS_MONO,
> +	PTP_TS_RAW,
> +	PTP_TS_MAX,
> +};

There is no need for a new set of enumerated values.  Why not use the
existing clockid_t ?

Thanks,
Richard
