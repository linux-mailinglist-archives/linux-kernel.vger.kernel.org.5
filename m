Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A34278F131
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbjHaQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHaQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:26:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913FEB0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:26:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso17989361fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693499184; x=1694103984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TTa8hbVsL/I1loUnddAOnRmxr7NnrFbpO6ura2fOOWQ=;
        b=gMoxgd8+1ob9QcOygbwHu7hobRRP2VXIuMYk8hrUdmq4jvfCJVKiMgnfUISSE6K0lk
         k9a9bAmucXwotc/CUBX/d4yVXz2EDr7QKdJOBEGeO6OPtWEJazpUywdT1JH15Kos5QqS
         XiKG4Gdo9i9J4sIczmPCP2EJ5AXddU2bEZktCbnnRaIHOjnxhxeZms7RtTmvCmet+UGj
         P255xBP1OqNI27T5WleJt55BOwv9+jJ8u+vK1YVxsQfLzxj+/GtrzCYaV3AO8ZWoa4BC
         1fljsCDKGsnd7AZ1mGvabS7KpUGolWC0OFWtpP829IPZIVRyTsLyjX8l3bVp3DyiBPG/
         uqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693499184; x=1694103984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTa8hbVsL/I1loUnddAOnRmxr7NnrFbpO6ura2fOOWQ=;
        b=Eqx1usBALZ9oc/cEm08espKCUwE8LFpTHAdy2Qqw+sAToQx4rrmOl5OejvNoyhpLja
         KJ6tOFaasHiLCWeJ2SycJ/js0DS/JSzw3V5FR4wgx3TSulmUT0wnnNW36RPIkUBgiOml
         2PZMDclipz4Cg/RhmjsXn5R+goL69cviGQh3asrbToVXRVYTNmqHG1Hu3EGBF4kg+Stq
         3b4mpnYW1VAgRqMdQ5nw8BUvUYfs+TqJTddcZi1rQ7ikHuQsmgimeLT85wKVTvhpBD74
         Q5EuL7fu3iNohFzwSxDMyTojkx1X4dTqGnxuS/+KITk++QXSqCPHr3Cjn4k0wbazgJ+8
         TACA==
X-Gm-Message-State: AOJu0Yx2gF117qkLrDMx8zASYE0oihteSB0nG8R7NNnNPLtoz0LFID55
        cySRYEB+0PTOHtWH2svR96Y=
X-Google-Smtp-Source: AGHT+IGgS+egWQY2ss7ToaGLxzZFTPyP9t1Rvk5a1ZTVUd56qBtVrotxrm0iOl4CLBrC/VhCcYHk4w==
X-Received: by 2002:a2e:9857:0:b0:2bc:d634:2210 with SMTP id e23-20020a2e9857000000b002bcd6342210mr4704283ljj.16.1693499183481;
        Thu, 31 Aug 2023 09:26:23 -0700 (PDT)
Received: from pc636 (host-90-235-3-170.mobileonline.telia.com. [90.235.3.170])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9d90000000b002bccfd37659sm386394ljj.99.2023.08.31.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:26:23 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 31 Aug 2023 18:26:20 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Message-ID: <ZPC/LGg9u0pk46MS@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <ZO/pwqWyxEoluNXv@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO/pwqWyxEoluNXv@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:15:46AM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Hello, folk!
> > 
> > This is the v2, the series which tends to minimize the vmap
> > lock contention. It is based on the tag: v6.5-rc6. Here you
> > can find a documentation about it:
> > 
> > wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf
> 
> Seems the wget command doesn't work for me. Not sure if other people can
> retrieve it successfully.
> 
> --2023-08-30 21:14:20--  ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf
>            => ‘Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf’
> Resolving vps418301.ovh.net (vps418301.ovh.net)... 37.187.244.100
> Connecting to vps418301.ovh.net (vps418301.ovh.net)|37.187.244.100|:21... connected.
> Logging in as anonymous ... Logged in!
> ==> SYST ... done.    ==> PWD ... done.
> ==> TYPE I ... done.  ==> CWD (1) /incoming ... done.
> ==> SIZE Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf ... done.
> 
> ==> PASV ... done.    ==> RETR Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf ... 
> No such file ‘Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf’.
> 
Right. Same issue as a last time. I renamed the file name but pointed
to the old name. Here we go:

wget ftp://vps418301.ovh.net/incoming/Mitigate_a_vmalloc_lock_contention_in_SMP_env_v2.pdf

--
Uladzislau Rezki
