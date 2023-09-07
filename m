Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA67975C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIGPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245511AbjIGPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:53:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839B7EFB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:43:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so1490352a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694101344; x=1694706144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLX7Bq6wnbRD6/SdSFqqliM0JJEUO0FAMrqo0kqc5TI=;
        b=VZY1e0xpcB8TQIHdhPgY6LGUpHjoMjXqUgOHEgfpvhmAslHQYiWhfK9wAV//wakwlz
         CXnAKtdfV1rA32zOjzwaFiUxh3OmzfSfC2h5S2lhZDAYvrrtq6qdFs36dbaTSNM1mTZm
         Ho8Ec2CT4JRgdDNHez+nsGOzurXWK4ZNKmWVaAOctL1P5BJkrcMQ0sYEOLIF5JVAB0RR
         XUS+9tIMIhbWWcezh3/WKviYjDxtQ0JvN1uTA+yTYtHieJ+Lbkax1p7z4LJJHHwmV6uj
         KzTT8Rjji3zuhnZrTWZg6HGZs/H+po3gSi28czJ5/VTnqf5kTX3WmPaC+4Yi+JUF2kBw
         tpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101344; x=1694706144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLX7Bq6wnbRD6/SdSFqqliM0JJEUO0FAMrqo0kqc5TI=;
        b=PEw836Ubxui+oY8DkJPElxd9mq61n1vupYYhGgPYAonDnqKpXX//ixodmjUPOQKbu5
         hAsr+LnjWefCx4q2hAqDslieWsGw/Zmqo10n5WRYdN61W/b2CGKArTMA0UlpgF+Flj4d
         2ELvt1lfROkadGTMAMacdPxrUHYSTY0MIcg9uklT4FV4Ut0hKz9fkagh0fK+477UabpH
         ZoTdbeYZiUUu1kpN7W+j4ytt0D0dbN2cXBuIPkixTNstpVsu6DRXUOHvYM2O1ZhFjTK4
         nnF9tfbGUEE8ayyw6AJWhlMeUubQmChxB+owjIf2zBqBBHP3H9g+9BMEF2lSR92+CqZ9
         Ps7Q==
X-Gm-Message-State: AOJu0YxpvU2rO0j//ycp0MhxpI0rhLriJXaHfTxTawLEmzHrn6OKIESq
        r3jOx+ZNMuuBN1COefuXgsXW0w/8bUQ=
X-Google-Smtp-Source: AGHT+IF+WSICpl9q9H+brNxoyZjwyqj3M4NSmCfgk21ugKY/BcmEIhuMQiG2HKK4eNTLI3u6Dah+FQ==
X-Received: by 2002:a19:700d:0:b0:4fb:829b:196e with SMTP id h13-20020a19700d000000b004fb829b196emr3847391lfc.2.1694079226496;
        Thu, 07 Sep 2023 02:33:46 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24bc5000000b00500a4679148sm400526lfq.20.2023.09.07.02.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:33:46 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 7 Sep 2023 11:33:43 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
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
Subject: Re: [PATCH v2 6/9] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZPmY98hbAo+/Lcf4@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-7-urezki@gmail.com>
 <ZPgWXgL1nLASjx8O@MiWiFi-R3L-srv>
 <ZPjQCSkKesWmWdB8@pc636>
 <ZPkT8RJJgY0HGwmC@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPkT8RJJgY0HGwmC@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:06:09AM +0800, Baoquan He wrote:
> On 09/06/23 at 09:16pm, Uladzislau Rezki wrote:
> > > >  static void free_vmap_area(struct vmap_area *va)
> > > >  {
> > > >  	struct vmap_node *vn = addr_to_node(va->va_start);
> > > > +	int vn_id = decode_vn_id(va->flags);
> > > >  
> > > >  	/*
> > > >  	 * Remove from the busy tree/list.
> > > > @@ -1594,12 +1629,19 @@ static void free_vmap_area(struct vmap_area *va)
> > > >  	unlink_va(va, &vn->busy.root);
> > > >  	spin_unlock(&vn->busy.lock);
> > > >  
> > > > -	/*
> > > > -	 * Insert/Merge it back to the free tree/list.
> > > > -	 */
> > > > -	spin_lock(&free_vmap_area_lock);
> > > > -	merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
> > > > -	spin_unlock(&free_vmap_area_lock);
> > > > +	if (vn_id >= 0) {
> > > 
> > > In alloc_vmap_area(), the vn_id is encoded into va->flags. When
> > > allocation failed, the vn_id = 0. Here should we change to check 'if
> > > (vn_id > 0)' becasue the vn_id == 0 means no available vn_id encoded
> > > into. And I do not get how we treat the case vn_id truly is 0.
> > > 
> > > 	va->flags = (addr != vend) ? encode_vn_id(vn_id) : 0;
> > >
> > Yes, vn_id always >= 0, so it is positive since it is an index.
> > We encode a vn_id as vn_id + 1. For example if it is zero we write 1.
> > 
> > If not node allocation path or an error zero is written. Decoding
> > is done as: zero - 1 = -1, so it is negative value, i.e. decode_vn_id()
> > function returns -1.
> 
> Ah, I see it now, thanks. It would be helpful to add some explanation
> above decode_vn_id() lest people misunderstand this like me?
> 
I got that feeling also. This makes sense, so i will comment it!

--
Uladzislau Rezki
