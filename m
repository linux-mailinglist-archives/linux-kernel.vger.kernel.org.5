Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617067F6A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjKXCMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXCMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:12:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0129E1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:12:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c871890c12so18490231fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1700791946; x=1701396746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h17AeJH/vAwlH2GqqKLdK7l5HtwpWvqKNZiJjWltD5g=;
        b=qF+hYw1gyrbLsbWeGiEDCctnoxGtXlfs5NPV5/1GGnTTBvgfzFJOFy+a5p5/kyMJwI
         TUmgKpVfdaM3NCeVkUXJWqIzmlp5PbE22B1S6cUZgL7eWO8t0eUBZ5vfJhoLENVEcGqt
         Sw2+ZiO+HK5to6hUYGdM5W0klsixq5sHqSvzo7+ELv8UhXtqN0q0FP+kpb5tzrgvkqbC
         O28StI8oUf9fR6X/rqHcJgiMVDPdnT6K54HWpAHaIgW90TOrZSU3SNKljsX8F2S9yp7N
         uxy3I+wPsu9nfnxyfNknDZvM27acwodg68iXeInvFzXOuiRNegyeoVVTDF0eZp69HuFr
         V55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700791946; x=1701396746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h17AeJH/vAwlH2GqqKLdK7l5HtwpWvqKNZiJjWltD5g=;
        b=DXDraZArrjP5tL2ain1zn9wL3eXNhljdAmHWffdOMzjvVqHm6DRvwED2r0vimb4ViW
         WSyV+Mj53lXfIulzF7iT6jSthXnoeF0uF0a9E/RuA0FOcfhworuQqMuK2va4B2eW4+AY
         4QSY9Q0pnBXA3kKutaYO7J0KbEovZJ7Putrw5ddspgcNL86ai7rKWxI2XwJ7Mkhd69lq
         DBq58ddCw5xQypddAk1DQbIBTP+gHX8uolylIiQPdLlZBX073RqI7NC5vQvZ3dSy3Sae
         jtTCKmaBsmyfJYanAxDfIjWcxucL7qW9CUFS0hjxYS9vjgCzqpCKkc12Ap3M0PSZWE4j
         qnMA==
X-Gm-Message-State: AOJu0Yx2+UUD1Wj69h/Fnm/B3NfR2rwl4jLA9Kyg4E55e6AojZUOKABN
        4dBKQpPzytdbWJIFrZptNQSCh/bwEI26OOiZwhgyVA==
X-Google-Smtp-Source: AGHT+IGTkMMu/oeAVyWpOz40u3BKEq8QkLhW7AGsLOoqKuxsiSQeaCWLWdVAHnMVGtxZ9Sw4qqI1Sg==
X-Received: by 2002:a2e:93cf:0:b0:2c5:6e01:58b8 with SMTP id p15-20020a2e93cf000000b002c56e0158b8mr598992ljh.37.1700791945729;
        Thu, 23 Nov 2023 18:12:25 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id ay14-20020a170906d28e00b009fad1dfe472sm1438586ejb.153.2023.11.23.18.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 18:12:25 -0800 (PST)
Date:   Fri, 24 Nov 2023 03:12:23 +0100
From:   Petr Malat <oss@malat.biz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <ZWAGhy4ZuYvKQeh2@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
 <325042d6-ddd0-4278-a082-9587af77cabe@paulmck-laptop>
 <20231123112207.417b502144a01fc94ad6f87d@kernel.org>
 <ZV8jkGVup4KvKiYb@ntb.petris.klfree.czf>
 <20231123231805.b4cb1b96426c956bd35bf53d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123231805.b4cb1b96426c956bd35bf53d@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Thu, Nov 23, 2023 at 11:18:05PM +0900, Masami Hiramatsu wrote:
> On Thu, 23 Nov 2023 11:04:00 +0100
> > On Thu, Nov 23, 2023 at 11:22:07AM +0900, Masami Hiramatsu wrote:
> > > BTW, we also need to make a block-list for some early params. some of those
> > > MUST be passed from the bootloader. E.g. initrd address and size will be
> > > passed from the bootloader via commandline. Thus such params in the embedded
> > > bootconfig should be filtered at the build time.
> > 
> > It's ok to configure these in the embedded bootconfig - in a case they are
> > provided by the bootloader, the bootconfig value is overridden, if not, the
> > value from bootconfig is used, so it works as expected.
> 
> I meant some params only bootloader knows, like where the initrd is loaded.
> Anyway, if user sets such value, it will break the kernel boot as expected :P.

If somebody sets these by hand, he probably knows what is he doing. I
remember myself hardcoding initrd size in Linux to workaround broken
bootloader.

I find it more important to warn the user when he tries to set early
options in initrd (assuming my change gets merged), as that's what
burned me.
  Petr
