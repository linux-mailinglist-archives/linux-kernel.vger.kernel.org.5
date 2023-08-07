Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688F7726E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjHGOEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjHGOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:02:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CA526D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:01:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686bc261111so3110805b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691416868; x=1692021668;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeJMC8uQd6uF4qr+WdPwE3eIC4QtXm265LEcDc12V2I=;
        b=CvLd0udIIP1521KeosdB+tY5lpPEIgLus4aqjuvQObaEOsfX3bjwvEWvdddpvR83vE
         ha/+/zOlWLT9Gy20nDNEyr+YI8F7KEtnmwUmyVdT+nywLx2ZCyowrCJgB9gU0bArEHyu
         FDTzxzgNsb2QAXnRI/se09JeXgajWDj5n6zGTlL2rs+lFhK5vO53nugR14U+sn1nsQv6
         MO/kyseFDJEFhvaREqm9VwHcu0+CE4LM2JQf3/U5TWsv0vRMZLNoxwPhIr//o0Rn173I
         1jqknazoL6LVpKmfC6r2PTIGINMHD+cl47qhUCc9/HdCxOyAfm+aqIYwtE75ZPfj9hu8
         /zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416868; x=1692021668;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeJMC8uQd6uF4qr+WdPwE3eIC4QtXm265LEcDc12V2I=;
        b=aY6yBBnVf/OTyE+S1B57574pUKT8a0rQyf4Y0Fq7QdcgfP0o1xt8/4P/gCldoKhSX3
         8F57iFFlQxlaYh32iboBvH/VtyAK+cISdbkeW6B2PQzRHuF84VlmmJomWc2lzQuVzms4
         ksRP9PyMlMlrSvobKkQRYFaMbR1wBNuy4USzgHNaIwM+j/frmGov2u/Nrw76IKdCpLBk
         4SQHiLhPXF0mPvTF8MtEvLIqf5M8HZ6OWGw0Bs0BPRxWkRTuJLkcRxmMtuQKTB1SLv1X
         /FvbZZ1tbL8uOo0klLkXPV0INZq8MW2S1JcVw7WRI0VHcd8xcpAggCJDZSt+wfwk87CA
         HiuQ==
X-Gm-Message-State: AOJu0YwZ8scrT4xhoT0fy4JgiWJKk0RpdvrEWymlLT8EhldKmOlO23Xe
        35IfOTqCCsKw69k9Rtdy6lcO5oLAA+bg2YHG
X-Google-Smtp-Source: AGHT+IH4PXx8yvkS3Pz7yzTEcs5JeZDuFy4E15+4oKFHrVbebrzOcSkqbOAlLfG3YmXPKNGwYcNpuQ==
X-Received: by 2002:a05:6a00:124b:b0:64a:2dd6:4f18 with SMTP id u11-20020a056a00124b00b0064a2dd64f18mr9315921pfi.13.1691416867280;
        Mon, 07 Aug 2023 07:01:07 -0700 (PDT)
Received: from [192.168.1.102] ([192.166.244.71])
        by smtp.gmail.com with ESMTPSA id t22-20020a62ea16000000b00666912d8a52sm6189445pfh.197.2023.08.07.07.01.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 07 Aug 2023 07:01:06 -0700 (PDT)
Message-ID: <64d0f922.620a0220.8c426.a761@mx.google.com>
From:   World Health Organization Empowerment Group 
        <sanderrobin72@gmail.com>
X-Google-Original-From: World Health Organization Empowerment Group
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: We have a Job opportunity for you in your country;
To:     Recipients <World@vger.kernel.org>
Date:   Mon, 07 Aug 2023 21:00:47 +0700
Reply-To: drjeromewalcott@gmail.com
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_FILL_THIS_FORM_SHORT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings! Sir /Madam.
                   =

We are writing this email to you from (World Health Organization Empowermen=
t Group) to inform you that we have a Job opportunity for you in your count=
ry, if you receive this message, send your CV or your information, Your Ful=
l Name, Your Address, Your Occupation, to (Dr.Jerome) via this email addres=
s: drjeromewalcott@gmail.com  For more information about the Job. The Job c=
annot stop your business or the work you are doing already. =


We know that this Message may come as a surprise to you.

Best Regards
Dr.Jerome Walcott
Office Email:drjeromewalcott@gmail.com
Office  WhatsApp Number: +447405575102. =

Office Contact Number: +1-7712204594
