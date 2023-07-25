Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B243F76201A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGYR23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGYR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFC31BFE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690306061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+/nqT6fQIVWmc2UMyym2/MQImAiAAqOHD7/JM8jKDc=;
        b=gfBvc5xG2My8swRxiomtc+VjwURC1Spre7Q1oNcDb5JFD3XKs8WzP6Irbl3m2ODTcXqLqh
        YGeeroxl4ZG/M1/9VmTMxDkMr3ZgE2J78yHg6rlw2vhC89ll6AHepJr2v5FdmP/zUeMKre
        IEuTfR9dFhmNXI8kIisQuHHXhZy0HQg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-RHfb8bl_MICdb88O3e95xQ-1; Tue, 25 Jul 2023 13:27:38 -0400
X-MC-Unique: RHfb8bl_MICdb88O3e95xQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3E9D29A9D28;
        Tue, 25 Jul 2023 17:27:37 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E2A9492C13;
        Tue, 25 Jul 2023 17:27:36 +0000 (UTC)
Date:   Tue, 25 Jul 2023 10:27:34 -0700
From:   Chris Leech <cleech@redhat.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: be2iscsi: Add length check when parsing nlattrs
Message-ID: <ZMAGBrszXmlCMomv@rhel-developer-toolbox-latest>
References: <20230723075938.3713864-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723075938.3713864-1-linma@zju.edu.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 03:59:38PM +0800, Lin Ma wrote:
> beiscsi_iface_set_param parses nlattr with nla_for_each_attr and assumes
> every attributes can be viewed as struct iscsi_iface_param_info.
> 
> This is not true because there is no any nla_policy to validate the
> attributes passed from the upper function iscsi_set_iface_params.
> 
> This patch adds the nla_len check before accessing the nlattr data and
> error return EINVAL if the length check fails.

Reviewed-by: Chris Leech <cleech@redhat.com>

