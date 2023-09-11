Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9E79B4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245562AbjIKVJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbjIKRA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:00:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D36110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:00:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502a25ab777so4783005e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694451652; x=1695056452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ik/CLJY3ojjVQTTRP/yRQOPIUe+r5uh1ajglYGBMWo=;
        b=Ntsba8dPb+FNey8h9DAQaE8OsXPU8iQ99l+dzqsueZOYuuwwO7R80ruqsP9Yu3Dutw
         sJZTp1fG5xDY5JNnfHlyZa9BCVkHQBAOzCR8Nxgf5vUj29PuE+XNXby2wsEqLF1JQ45Q
         ID5krQG8xAuMENyGvFKumAzqje9V8e9MTqErEXhOZSutyjtAtl3hnqnuee6CBB/+eHtN
         0m9+e//OD+jcjFQ4SgrO3RVSZTOXbMTePI7ugyxkp3I2zi/ln/24aZZNOfvplutNZfg5
         el9ki3peQN/6z/xiLxXTpy7HU5SEpDxVHA4/09AxPBeW5BtKWHisvfC1upNsg1jmNbIb
         xzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451652; x=1695056452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ik/CLJY3ojjVQTTRP/yRQOPIUe+r5uh1ajglYGBMWo=;
        b=eu7Lk12z9j1xvNsQyyaDaaV2/On8OdMvIDB25ZqEinlElksOE1W7i1aC2Lpcxxdr8v
         u4sMWi/RQM90h1Wj5vjA347bR0rNGEciipHNYhgz8hW0ntj2m5R25w/QZLlmmGh7pT2a
         97urBRFZRBUdQKgf8hcWoP/07RAogxBNEsoZJQyl7oohrcDkTU/rMdMNtRF4UxLkW5bn
         ouasLbpfJt5MsVLA3R074T7r3TQQM4ez1oea1mLpOvUITt3okFbOk2Qg6OmQgm6STbgZ
         GgkikrACqOOvvRKR4y9nn3uQSLmTDPhdJggu1HguPtUZmru58xgapXeq/GZg97Dc5tTE
         twlA==
X-Gm-Message-State: AOJu0YzxLDPHtMptp/1xUrciKf6ZaPj9Edafn7ARv9egBfnhrC/tbGPD
        +QUnQ9hQiy0fa0J2ASDVGCo=
X-Google-Smtp-Source: AGHT+IH57GSqSeazun+3FynPqRLRiA7N8k1Dll2hCanssFVJXYE4705eH1VS9yQfvlHeIwLZQjExRw==
X-Received: by 2002:a05:6512:1283:b0:4fd:c844:6a43 with SMTP id u3-20020a056512128300b004fdc8446a43mr10868135lfs.43.1694451651382;
        Mon, 11 Sep 2023 10:00:51 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id er12-20020a05651248cc00b004ff91a94156sm1404724lfb.121.2023.09.11.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:00:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 11 Sep 2023 19:00:48 +0200
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
Subject: Re: [PATCH v2 5/9] mm: vmalloc: Remove global purge_vmap_area_root
 rb-tree
Message-ID: <ZP9HwP7FT5e62gee@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-6-urezki@gmail.com>
 <ZP6B/vAsZ3z+k6af@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP6B/vAsZ3z+k6af@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Similar to busy VA, lazily-freed area is stored to a node
> > it belongs to. Such approach does not require any global
> > locking primitive, instead an access becomes scalable what
> > mitigates a contention.
> > 
> > This patch removes a global purge-lock, global purge-tree
> > and global purge list.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 135 +++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 82 insertions(+), 53 deletions(-)
> 
> LGTM,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Applied.

Thank you for review!

--
Uladzislau Rezki
