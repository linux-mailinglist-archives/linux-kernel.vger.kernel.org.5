Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40657B4CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjJBHvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJBHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920E8C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696233029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5fJ5s4tSJ75JUyYMT3IWTY1CcZbtcp06il4dgPzNKo=;
        b=gGdL8YYsOGjOfc2o3Jyisk4qJpL7PM32LBi4/aYCKNaFtB9JLhXehwX8vDAF0MXcvdZE/m
        LVU+ohgDbK1lnot2kGaUpY2ONaZUC1U1vcAHu/4lKiI3ObQpbFDaZohflxDiqWKz5l2rcq
        TFcciADtxg7y9YdiUS1ywi3qY6mr4UY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581--tsNFju0NPqPdIVzNhoEZQ-1; Mon, 02 Oct 2023 03:50:23 -0400
X-MC-Unique: -tsNFju0NPqPdIVzNhoEZQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d0c38e986so224545946d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696233023; x=1696837823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5fJ5s4tSJ75JUyYMT3IWTY1CcZbtcp06il4dgPzNKo=;
        b=eJY5F0KJAWoOjEB4HdPSDJ0hA9GOsp3JEVZA8C3H474fKrjhYGwaFGS3qZUMlSH+G/
         R0qKb0qvD5ICiU/r11ezJuKUWVSOZBpTBJMmHhKvAjgjmjBOwmCYc46/i8pivrm7Vdrg
         DM/5samdx8utvKOuGZIuQ/JO7w9td8KXZzW/6KfgP2VZUF/HWNJVuQ8fL52OIdRl9IOH
         T0HrfF06KYSZ/IuN5pM4ryvpbCF14NIqc7bhGDgUOBRRdwd/bGu3+UctFSouF4PFAHcm
         sWKdxo2Db8dzKWOn1SCjBbQniRx31eVL9qqaUobJDxPEir9ReM4kdKwseRt8crfWP18Z
         PTcA==
X-Gm-Message-State: AOJu0YwdrlGWc8MGj51GolwL+6KeuSsIor4ylDQ1CoSlo5zSmipmgIac
        nq8COBbtmBXy6LAOdYupLVSqqUiRS5kBPYAtGf52+CCgqlLAFstZgdLCphRIbI5aJZtWYWFSjkp
        Js8vkaaYrAq+O3S7gtClIdNIK
X-Received: by 2002:a0c:8d07:0:b0:655:8a4b:a3fd with SMTP id r7-20020a0c8d07000000b006558a4ba3fdmr7491364qvb.63.1696233023416;
        Mon, 02 Oct 2023 00:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIatO2dq8szhlU914qNxjhFLjpRo1iSQwCyioR13FeEegFPwRpmsPfQlILV+sD5kYQXi2J3g==
X-Received: by 2002:a0c:8d07:0:b0:655:8a4b:a3fd with SMTP id r7-20020a0c8d07000000b006558a4ba3fdmr7491357qvb.63.1696233023100;
        Mon, 02 Oct 2023 00:50:23 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id r13-20020a0cb28d000000b0064f4e0b2089sm5527376qve.33.2023.10.02.00.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:50:22 -0700 (PDT)
Date:   Mon, 2 Oct 2023 00:50:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chris Leech <cleech@redhat.com>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
 <2023093002-unlighted-ragged-c6e1@gregkh>
 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
 <2023100114-flatware-mourner-3fed@gregkh>
 <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
 <20231002060424.GA781@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002060424.GA781@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:04:24AM +0200, Christoph Hellwig wrote:
> On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> > Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
> > in particular these two (from the e529d3507a93 dma-mapping pull for
> > 6.2):
> 
> That's complete BS.  The driver was broken since day 1 and always
> ignored the DMA API requirement to never try to grab the page from the
> dma coherent allocation because you generally speaking can't.  It just
> happened to accidentally work the trivial dma coherent allocator that
> is used on x86.
> 

re-sending since gmail decided to not send plain text:

Yes, I agree that it has been broken and misusing the API. Greg's
question was what changed though, and it was the clean up of
__GFP_COMP in dma-mapping that brought the problem in the driver to
light.

I already said the other day that cnic has been doing this for 14
years. I'm not blaming you or your __GFP_COMP cleanup commits, they
just uncovered that cnic was doing something wrong. My apologies if
you took it that way.

Regards,
Jerry

