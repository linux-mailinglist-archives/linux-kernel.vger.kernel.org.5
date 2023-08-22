Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD2784655
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjHVPza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjHVPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:55:28 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5EE7D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:54:55 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48d1412c5c5so939597e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692719684; x=1693324484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyWiLtgW4rH+JKJqsR/UwcQBV8o5lraFKhrBSaT+Ps8=;
        b=NT9JTOvtFdmhasmygeVtSzIJVN74iudjI0QTUJny3AeS7qeldGSDrv7oJDtSS3KAC9
         0dFApr2PitMRVcwgdL32fVPDHnH8mUAFHixpqtY7+Zj25SkL0AnJQxTqWtRl2cuQ4X9F
         Odv6PZizpLio4AtEU86+ByynRvlC2NaUeiQ3/Hu5fSOgwVcOc8d0LJBpfm32U9Vwjl9L
         a5A4saVCGeMgKEIGWXSplEAvDvLFwZHagf3JryhKcg+TBRs+yjve7FL01ECAzu2PK7iV
         QgYKnAvQDF4+JCzHTOY7KGQgGCsNGzwd78hQjM74mJ9v8RfYdaKIjSOUOsMiXMioPAY5
         mhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719684; x=1693324484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyWiLtgW4rH+JKJqsR/UwcQBV8o5lraFKhrBSaT+Ps8=;
        b=j0Pe4T/mVuVEgvcnStJ0RynrDGK4aYPY3tOXqO5uNJUdj5yCw9hpDD2/0Si9jmdiPF
         Cv/MloAJj5gPZFJR7i3mGRNGm0yfGqSOlHhNK/UHgo07qivzz3DjTzPR/3zkKXHIR6JN
         6nRxDcAfYRfmRkcqh4z6JGt5R5evoDt3KrbJiLXCoxkjhF5BhaFEQunHuYV6n7JxnQLp
         doc1QEn9ibyH7JQs6xHcTMtI9a3jtD91RZIWMe1HvIpVz/fU+Uy6FIivggZ8u4b4aCL6
         ykJSPEjpjxVPJqHojeU2Z7p2EeLhGRhuNoCnG7U1qczcildzoysOPwm6ymOEWX9mn5Xv
         ZFaQ==
X-Gm-Message-State: AOJu0Yxuwxzfg/gYHszZWP3ciNbNnWN71gEFazd0a+9Wfggo+NQ36Qn+
        yM2NXIKbuFD6mFPWIRJiEqMj6Q==
X-Google-Smtp-Source: AGHT+IHm+ZQkZnfqa1opBR5Uh1UPr48byTq5NCF+mGziAzbMuhJCaJmtH8trQUCfo/FpvCkPMs7e+Q==
X-Received: by 2002:a1f:4e45:0:b0:48d:189b:6f3b with SMTP id c66-20020a1f4e45000000b0048d189b6f3bmr5428427vkb.12.1692719684095;
        Tue, 22 Aug 2023 08:54:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c13-20020a0ce14d000000b006472b16d141sm1625144qvl.127.2023.08.22.08.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:54:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qYTiM-00FBsa-Rd;
        Tue, 22 Aug 2023 12:54:42 -0300
Date:   Tue, 22 Aug 2023 12:54:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     sharmaajay@linuxonhyperv.com
Cc:     Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v4 3/4] RDMA/mana_ib : Create adapter and Add error eq
Message-ID: <ZOTaQt9Mdq4ncTtv@ziepe.ca>
References: <1692719255-20183-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1692719255-20183-4-git-send-email-sharmaajay@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692719255-20183-4-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 08:47:34AM -0700, sharmaajay@linuxonhyperv.com wrote:

> +static void mana_ib_soc_event_handler(void *ctx, struct gdma_queue *queue,
> +				      struct gdma_event *event)
> +{
> +	struct mana_ib_dev *mib_dev = (struct mana_ib_dev *)ctx;
> +
> +	switch (event->type) {
> +	case GDMA_EQE_SOC_EVENT_NOTIFICATION:
> +		ibdev_dbg(&mib_dev->ib_dev, "Received SOC Notification");
> +		break;
> +	case GDMA_EQE_SOC_EVENT_TEST:
> +		ibdev_dbg(&mib_dev->ib_dev, "Received SoC Test");
> +		break;
> +	default:
> +		ibdev_dbg(&mib_dev->ib_dev, "Received unsolicited evt %d",
> +			  event->type);
> +	}
> +}

Did I miss something? What is the point of all this? Please don't add
test/dead code to the kernel. Come back when you have an actual use of
events on this channel.

Jason
