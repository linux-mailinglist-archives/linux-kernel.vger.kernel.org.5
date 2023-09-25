Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B97AD4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjIYJjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIYJjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:39:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E99C;
        Mon, 25 Sep 2023 02:39:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F350C433C8;
        Mon, 25 Sep 2023 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695634749;
        bh=tT5Hiup5l7fkll/89pLjodXoqI5fZoNrP5R9QACjOaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ty6SVc5ODGX47WnWYALHJL214/fZV6+UJsASZbX+jn9Diw98NWrKCyUSVPLqFHAgq
         UKVahZ3wqeU7Nm0B7X2UleqdsWs0PU1l5j/y/RnItM+/tsrDkyOwtphSsVboogWNeA
         Yi7O032jckrE8YmUMqy7w+L14ZVR7lar5nISKrwoE2QDvZ5OZMIZnw9OmjZqBFKT/h
         Ke3hHCBBE6AsmXvDNNXRj5EjayA9/2ZjVAC/QBqC5HMqIlLbspH29W7SP5uv3aK7z/
         iYj1fSgj1hnkvUzW1HRWQ8q2nY85QlZRUKuF8pXyzFwj4ShUckDxABG3Inz5f9wzYl
         YNlD5/6qbNwOw==
Date:   Mon, 25 Sep 2023 11:39:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] ovl: disable IOCB_DIO_CALLER_COMP
Message-ID: <20230925-desorientiert-fahrverbot-d95744ccc37f@brauner>
References: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
 <CAOQ4uxj7hC5iGfJSD35xAGC97x32y9nnKk8qJa8ux6owpgT1wQ@mail.gmail.com>
 <6d513d21-127c-447d-bc08-3f21c94b4132@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d513d21-127c-447d-bc08-3f21c94b4132@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No problem - and thanks, maybe Christian can pick this one up? I

Snatched it I've got a pile I need to send to Linus this week anyway.
(Thanks for the Cc, Amir!)
