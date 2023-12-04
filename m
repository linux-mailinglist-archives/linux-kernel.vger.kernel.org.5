Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5543A803665
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345426AbjLDOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345241AbjLDOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC63E192
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d03fb57b69so17088535ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701699749; x=1702304549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/6PTbVtB3zVokWtSQdHSg1VVHHGG1qjACuIqhydepk=;
        b=IrMgTp5W6Czz2vqsMeFSw4uZKMXRR9DAG7RwMv9Mm8VP74TyLdg/BpFfECNVoUln5i
         91HTYV24uPdQKLxqzn6nXco6sNWihuITlMGMy2ckeJ++5Un0TUwqmqyBBBNacoKX+qCb
         gqDdMdGOdbU6M5Ev/3xvL2oSopj2GqfyB3iGGWgWerrNgdZIhswfzPWv3rr3e2gsgWJi
         npQwkc2p4+ba23AJph4DiBSpRMLfx//jno2+IymtNGzPOCscZp/MDHcrcujK5/Spt7ag
         Q3nnxRsE9djTlCW3964bYFesGqBzgttHbSQsurJJc5LmrYZUaSH6W54pt2MrK2pqDIoA
         bVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699749; x=1702304549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/6PTbVtB3zVokWtSQdHSg1VVHHGG1qjACuIqhydepk=;
        b=F0ul/ilm5O+U40CP96Tns4kyKM5hX3NQcxjVd+IffQaVeZ1M3h8BtgqXqACz4r8e36
         yBivMMoegmPv0+b+0JuDMTQqYh+0k6J0RJVmzq5i066aZf7mONlKgOD1OFO8dXCDgtUi
         XuUtBcYolXUp04ihUsYqGd8tyX2GVg04EkhMykBjULri7r7sMDQjyz/zqWRxR/GFUwhK
         4kfqW0Afjgc0o/+jGo6UWIemg3KgndJU+JQv0SL4dml1OygovW59zSmuFeuQWfVY1WcO
         yy0ysKo4F+5Pi+mAHmJBaceDnALIDqVr8ZhDoF5NCAcI9wOkMVGm03HWqsQi1aByrTpw
         Ncdw==
X-Gm-Message-State: AOJu0Yy+5QHewBDoXzdspX7AB7Ug+bbjVBxh6y4alACjfpqfTighozXl
        7WurBkq0rpGxZSNXC6NlgnLGmQ==
X-Google-Smtp-Source: AGHT+IFuReW0EtFvGpVnLvATqzbXHkv+nXz4UYkvMLzZKMK4lceKLNojPmXK/h7uONQe8Db2nBOfMA==
X-Received: by 2002:a17:902:7292:b0:1d0:a084:b009 with SMTP id d18-20020a170902729200b001d0a084b009mr1121879pll.108.1701699748856;
        Mon, 04 Dec 2023 06:22:28 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001d078445059sm4384384plb.143.2023.12.04.06.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:22:27 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:22:24 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Subject: Re: [PATCH v2 11/28] binder: do unlocked work in
 binder_alloc_new_buf()
Message-ID: <ZW3goGJBeqTsScI7@google.com>
References: <20231201172212.1813387-12-cmllamas@google.com>
 <20231204115704.40543-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204115704.40543-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:57:04AM +0000, 'Alice Ryhl' via kernel-team wrote:
> > Extract non-critical sections from binder_alloc_new_buf_locked() that
> > don't require holding the alloc->mutex. While we are here, consolidate
> > the checks for size overflow and zero-sized padding into a separate
> > sanitized_size() helper function.
> > 
> > Also add a few touchups to follow the coding guidelines.
> > 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> > +	if (IS_ERR(buffer)) {
> > +		mutex_unlock(&alloc->mutex);
> > +		goto out;
> > +	}
> > +
> > +	buffer->data_size = data_size;
> > +	buffer->offsets_size = offsets_size;
> > +	buffer->extra_buffers_size = extra_buffers_size;
> >  	mutex_unlock(&alloc->mutex);
> > +
> > +out:
> >  	return buffer;
> >  }
> 
> You could also write this as:
> 
> 	if (!IS_ERR(buffer)) {
> 		buffer->data_size = data_size;
> 		buffer->offsets_size = offsets_size;
> 		buffer->extra_buffers_size = extra_buffers_size;
> 	}
> 
> 	mutex_unlock(&alloc->mutex);
> 	return buffer;

There is a subsequent patch that adds more work after this and makes the
goto statement a better fit (patch 19/28)... at least IMO.

--
Carlos Llamas
