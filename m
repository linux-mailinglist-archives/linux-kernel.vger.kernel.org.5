Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CF7E0C19
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377819AbjKCXSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKCXSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:18:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D745D5A;
        Fri,  3 Nov 2023 16:18:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bcef66f9caso553793b3a.0;
        Fri, 03 Nov 2023 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053527; x=1699658327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUmRHvTQc1DzXbF2Te1K0K+hGK6pEUjIwadabL+ZWL0=;
        b=ERIPyEnCh0JAWgUhr3LH5Yl06w2QGJSjKWkMefkrqT6BLwKgrj3T49xPbZVTuh89ud
         OQsBxPXDD0vbBZamvz9Qo+T4Yj0YpSzkKPe+vV0AfXXvfSI9lJDibnpxTPC8HAdNKjfr
         f/DR6aAGoTOd1izypmkyiQf2Iiw7ZL9KcK099WmGCPoH3tYuqCOiI66vGk5zZ1cG2WBE
         vm7xN1XynN/9uCnAeoUeTZaXEGeWlh8Q7a1KF4QAWwO4ogOMXbnUbPgOAferfs6Sq+wK
         AZ/pGoCT9BfpxzCzSlRZSfz2lebomRXu7pJjDKL1Za5OQjYOtF1gFPdS/p5hGdKgIcUR
         Kaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053527; x=1699658327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUmRHvTQc1DzXbF2Te1K0K+hGK6pEUjIwadabL+ZWL0=;
        b=ernqL2vmOJbYnLiJqTPy5ehD34vavYiw6RkDyS+CsIY7M183ic1tMbXDJ7TI5EKIHh
         BqJCwL7QHBAoOYBmVqyfNloPqzyRlXwG4d4jx2nscnzLWSMPCak3xwGizgplezQKei7g
         ITGpfUA0iD6gma2wUE0iWMl6Cz83eEaWT2PCAOGIDVRftAS199WiR/0n5UEl3ljeq9x5
         qgYVODasJnyI9PEe8OJY26miG6h4JeYYLKiJyKEqgsqR00nZkZxWEe0DxnsE1/9QacKg
         mFgEQfbfDFFQ4i4ZTTjH6hPbrfBIKCX9K2cGCnRcwhN8aNAo7XXV2dn0mivUEy9rJXXR
         uHpg==
X-Gm-Message-State: AOJu0YzgdMlgcaFiZL1CUyLWKvQ0QKJxqoAS8n5vL3MLvEoTIWBxdR/J
        UQ66PkE1Ed5gDhcFy8HT3mo=
X-Google-Smtp-Source: AGHT+IHicUMdnVfm2WasDY3icooZua+bYT643mqOC+1cA4aWr/7FDqm+0ElhfQebLCHsNbuXSo51zA==
X-Received: by 2002:a05:6a00:468e:b0:6c0:81a3:fe4c with SMTP id de14-20020a056a00468e00b006c081a3fe4cmr24831172pfb.3.1699053527619;
        Fri, 03 Nov 2023 16:18:47 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id y11-20020a62f24b000000b006c067f1b254sm1880560pfl.122.2023.11.03.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:18:47 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:18:44 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     jeremy@jcline.org, davem@davemloft.net, habetsm.xilinx@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V3] ptp: fix corrupted list in ptp_open
Message-ID: <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>
References: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 09:15:03PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption, use mutex lock to avoid this
> issue.

The problem is the bogus call to ptp_release() in ptp_read().

Just delete that.

No need for another mutex.

Thanks,
Richard
