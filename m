Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821E276D0CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjHBPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjHBPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:00:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A130E8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:00:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so36440915e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690988431; x=1691593231;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0B9n4BoQGKJhtTSxI1M2Z+FXSAxvxddim356lxqalw=;
        b=XJS29n863up9xj2aMoG3YHyatpMO/MPalREmBPW8nmjgU8KAoGPc6zDLYxXQMvFfZV
         0/Sa0BHc/4HI0Lr3csi3ksCJH2vcb81iO1GdGog4Qh37S2sXCWEaar9yXXayOCzmSK80
         Dtk/dR/z8/FesRPFXHZC/i69aA2RzbUPFjsbH7UNP6+pfWVwHZSakGyEk8zd75mI2Blz
         JRKR/MXIixEv8OVccVm0WQ2AjOzyVbeRBpNdTiEGlQ4nGpZi/FZedc4jKZxV14gmybfv
         Tzfm9heuJfx3sm0eP4J93tnup6IaCDRkkZsjF9qLYqe/qmZlDjiPEUWDvAUXFbSEEcG3
         drMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988431; x=1691593231;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0B9n4BoQGKJhtTSxI1M2Z+FXSAxvxddim356lxqalw=;
        b=WE65lRjbiwlYMQBmh11GlscF2LPHBHIWhJdDRar0S1zIpFgSuWr/ATHXoDzCLbY4iR
         aZvBvaRFF8gvkvVkEO7/PMUQg+338OL6FFgyWySfOXPLi2AinfTQvXO5FZ2paiHpqNuG
         ulN6ZGSwZGhjKpmBQMkoFNtyTSACrVx+SLP7NpDk6nXBg2dtoxCkWIP0QCt5MtskzrHV
         a9UXDGN8xd9ZdfQ+zel08Z46Ch/5K1nKx0XtFNgQpTATj71lzG9kMyGw3bVyG1hdIWEc
         b3dKEtbvpBDKEmLvnzTnIgEpn6BQg/7oVYeXGfdNkT9x1a6+a81clx7S1qhwGiu0KyUY
         9azA==
X-Gm-Message-State: ABy/qLZf878Q+ojXS49NAKzF9k3eUQFO0wYk75b/3wnWVCoZ8a6gVrEv
        CFr7MBd+M0qpstcmDhh9pU9kaw==
X-Google-Smtp-Source: APBJJlH+CrrttCjxWTJuERu7b3+cTt1JRnzLk3CvbktL36TDbm3vLFfWOZaYR/yUbuuW2gtcsRc6aQ==
X-Received: by 2002:a05:600c:3644:b0:3fb:b1af:a455 with SMTP id y4-20020a05600c364400b003fbb1afa455mr4829810wmq.5.1690988431507;
        Wed, 02 Aug 2023 08:00:31 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w10-20020a1cf60a000000b003fe1afb99a9sm1918418wmc.11.2023.08.02.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:00:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
In-Reply-To: <1685972918-30371-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1685972918-30371-1-git-send-email-quic_ekangupt@quicinc.com>
Subject: Re: [PATCH v1] misc: fastrpc: Pass proper scm arguments for static
 process init
Message-Id: <169098843059.77085.12739943578767946779.b4-ty@linaro.org>
Date:   Wed, 02 Aug 2023 16:00:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Jun 2023 19:18:38 +0530, Ekansh Gupta wrote:
> Memory is allocated for dynamic loading when audio daemon is trying
> to attach to audioPD on DSP side. This memory is allocated from
> reserved CMA memory region and needs ownership assignment to
> new VMID in order to use it from audioPD.
> 
> In the current implementation, arguments are not correctly passed
> to the scm call which might result in failure of dynamic loading
> on audioPD. Added changes to pass correct arguments during daemon
> attach request.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Pass proper scm arguments for static process init
      commit: 64227235abd9a3ebfb5927dff2202771ffc92b8b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

