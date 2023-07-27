Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674197646AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjG0GVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjG0GVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:21:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3F1990
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:21:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso5900465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690438869; x=1691043669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJVdwD2hN1IoV2iHEFfG+qqTN9wFexemBdbel1dZ6/0=;
        b=jOdOIVAoSVB6mUY+/XF74SvOGVCPzCApWYNMNO7abuOVW8e8S2iK83xe3k41Jm6poH
         j7j21aDANuJdILLIFcpjma2bm2ZxglHLRgiEq8dtK11DKz3omZehCTzTgUNf/Ec4ohHB
         +Q/+V42Eiwr13mKbKdmyPk/JyGR8QULoO3kyAH26m9b3IE/4dM4LgKX021QeMoYVxd/r
         /qDq/1DjStCa/Q2FAxTflQtUz+78+z2HDJz9aDPa80iwZIQo0yY/+TmmqwobsMtaDMu3
         o61eABOU4ygCtkRP3cMvxObriYkqIn0/x2pgS506IwJ1Pj8ytOIncnUM1lmrYIDFm7I2
         eM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690438869; x=1691043669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJVdwD2hN1IoV2iHEFfG+qqTN9wFexemBdbel1dZ6/0=;
        b=VasGJ2Bh9twUpgGO8DsELtilBgsby2XzOwnA/JEtUBrZQA6ya39sfHCo/gpt2Up3bd
         y58N3ABzXDNj51drE9yQEmtmd0tNJo9e6lyaEritIyA7Yx1GiQbjrRw1g39eMJSV9sql
         /I1aNLnsvX8sGI2Es5rt071dmCQZ1o0Lv+0tGVKByO6wA0PGPixe9bJzI+8kgDWAzOOa
         7+lxHcoAasYhl7C+ZUQvwdBBV8zsDySo2+UXwMDhO/Wq+mIDsxybgW4XJ/ZiMqgU0+xb
         vj3c8bfqUUvPNnPbgpZOKz02vgj2aCgoUUDOQSF2UYLYexwR7l2p1dYQbTQSx9+v42XY
         4eeg==
X-Gm-Message-State: ABy/qLZH9tEBNGcz/a56FBleP2aAdzmCjZNaZgKci86xb8dKJQngrPnc
        qzjcVA2+W9QHgF06JvnymAoW/Q==
X-Google-Smtp-Source: APBJJlF3IgSEbyph9IM4JI2qxZemsymqPAaq2UVNfuIr0Q6pddfHRid63sQxM6o3GBzU1yNQslwnMg==
X-Received: by 2002:a05:600c:2244:b0:3f9:c8b2:dfbd with SMTP id a4-20020a05600c224400b003f9c8b2dfbdmr837449wmm.19.1690438868685;
        Wed, 26 Jul 2023 23:21:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q14-20020a7bce8e000000b003fb41491670sm3715509wmj.24.2023.07.26.23.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 23:21:08 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:21:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH 2/5] hp-bioscfg: Fix memory leaks in
 ordered_list_elements_from_package
Message-ID: <77867e93-7785-457c-9e37-4b41503bb509@moroto.mountain>
References: <20230725220056.25560-1-jorge.lopez2@hp.com>
 <20230725220056.25560-3-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725220056.25560-3-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I went through this pretty carefully.  There is a small bug in the
ORD_LIST_ELEMENTS case where the value_len is wrong.  Otherwise, I
complained a little about style nits...  You can feel free to ignore
everything except the ORD_LIST_ELEMENTS stuff.

regards,
dan carpenter

drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
   129  static int hp_populate_ordered_list_elements_from_package(union acpi_object *order_obj,
   130                                                            int order_obj_count,
   131                                                            int instance_id)
   132  {
   133          char *str_value = NULL;

It would be better to make str_value local to the loop.  Then we
could delete all the str_value = NULL assignments and the exit_list:
code at the end.  At the end of the loop we could do something like:

	kfree(str_value);
	if (ret)
		return ret;

   134          int value_len = 0;
   135          int ret;
   136          u32 size;
   137          u32 int_value = 0;

It confused me that it's called int_value when it's not an int.  Just
call it "u32 value = 0;".

   138          int elem;
   139          int reqs;
   140          int eloc;
   141          char *tmpstr = NULL;
   142          char *part_tmp = NULL;
   143          int tmp_len = 0;
   144          char *part = NULL;
   145          struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
   146  
   147          if (!order_obj)
   148                  return -EINVAL;
   149  
   150          for (elem = 1, eloc = 1; elem < order_obj_count; elem++, eloc++) {
   151                  /* ONLY look at the first ORDERED_ELEM_CNT elements */
   152                  if (eloc == ORD_ELEM_CNT)
   153                          goto exit_list;

We really expect to exit when eloc is ORD_ELEM_CNT.  So I think this
would be more clear as:

	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++) {

I don't really know what eloc stands for...  dst_idx?

		if (elem >= order_obj_count)
			return -EINVAL;

		obj = &order_obj[elem];

Let's move the "Check that both expected and read object type match"
stuff from line 173 up to here.

		if (obj->type != expected_order_types[eloc]) {
			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
				expected_order_types[eloc], elem, obj->type);
			return -EINVAL;
		}

   154  
   155                  switch (order_obj[elem].type) {

	switch(obj->type) {

   156                  case ACPI_TYPE_STRING:
   157                          if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
   158                                  ret = hp_convert_hexstr_to_str(order_obj[elem].string.pointer,
   159                                                                 order_obj[elem].string.length,
   160                                                                 &str_value, &value_len);
   161                                  if (ret)
   162                                          continue;

return ret;

   163                          }
   164                          break;
   165                  case ACPI_TYPE_INTEGER:
   166                          int_value = (u32)order_obj[elem].integer.value;
   167                          break;
   168                  default:
   169                          pr_warn("Unsupported object type [%d]\n", order_obj[elem].type);
   170                          continue;

return -EINVAL;

   171                  }
   172  
   173                  /* Check that both expected and read object type match */
   174                  if (expected_order_types[eloc] != order_obj[elem].type) {
   175                          pr_err("Error expected type %d for elem %d, but got type %d instead\n",
   176                                 expected_order_types[eloc], elem, order_obj[elem].type);
   177                          kfree(str_value);
   178                          return -EIO;
   179                  }
   180  
   181                  /* Assign appropriate element value to corresponding field*/
   182                  switch (eloc) {
   183                  case VALUE:
   184                          strscpy(ordered_list_data->current_value,
   185                                  str_value, sizeof(ordered_list_data->current_value));
   186                          replace_char_str(ordered_list_data->current_value, COMMA_SEP, SEMICOLON_SEP);
   187                          break;
   188                  case PATH:
   189                          strscpy(ordered_list_data->common.path, str_value,
   190                                  sizeof(ordered_list_data->common.path));
   191                          break;
   192                  case IS_READONLY:
   193                          ordered_list_data->common.is_readonly = int_value;
   194                          break;
   195                  case DISPLAY_IN_UI:
   196                          ordered_list_data->common.display_in_ui = int_value;
   197                          break;
   198                  case REQUIRES_PHYSICAL_PRESENCE:
   199                          ordered_list_data->common.requires_physical_presence = int_value;
   200                          break;
   201                  case SEQUENCE:
   202                          ordered_list_data->common.sequence = int_value;
   203                          break;
   204                  case PREREQUISITES_SIZE:
   205                          ordered_list_data->common.prerequisites_size = int_value;
   206                          if (int_value > MAX_PREREQUISITES_SIZE)
   207                                  pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");

	ret = -EINVAL;
	break;

   208  
   209                          /*
   210                           * This HACK is needed to keep the expected
   211                           * element list pointing to the right obj[elem].type
   212                           * when the size is zero. PREREQUISITES
   213                           * object is omitted by BIOS when the size is
   214                           * zero.

It's not really a HACK.

	/*
	 * If prerequisites_size is zero then there isn't a PREREQUISITES
	 * object so skip that and jump to SECURITY_LEVEL.
	 *
	 */


   215                           */
   216                          if (int_value == 0)
   217                                  eloc++;
   218                          break;
   219                  case PREREQUISITES:
   220                          size = min_t(u32, ordered_list_data->common.prerequisites_size,
   221                                       MAX_PREREQUISITES_SIZE);

If we returned when we hit invalid data then there is no need for this
min_t().

	size = ordered_list_data->common.prerequisites_size;

   222                          for (reqs = 0; reqs < size; reqs++) {
   223                                  ret = hp_convert_hexstr_to_str(order_obj[elem + reqs].string.pointer,
   224                                                                 order_obj[elem + reqs].string.length,
   225                                                                 &str_value, &value_len);

This is fine but it might be nicer to do what ORD_LIST_ELEMENTS does
and use tmpstr instead of str_value.

   226  
   227                                  if (ret)
   228                                          continue;

break;

   229  
   230                                  strscpy(ordered_list_data->common.prerequisites[reqs],
   231                                          str_value,
   232                                          sizeof(ordered_list_data->common.prerequisites[reqs]));
   233  
   234                                  kfree(str_value);
   235                                  str_value = NULL;
   236                          }
   237                          break;
   238  
   239                  case SECURITY_LEVEL:
   240                          ordered_list_data->common.security_level = int_value;
   241                          break;
   242  
   243                  case ORD_LIST_SIZE:
   244                          ordered_list_data->elements_size = int_value;
   245                          if (int_value > MAX_ELEMENTS_SIZE)
   246                                  pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");

ret = -EINVAL;
break;

   247                          /*
   248                           * This HACK is needed to keep the expected
   249                           * element list pointing to the right obj[elem].type
   250                           * when the size is zero. ORD_LIST_ELEMENTS
   251                           * object is omitted by BIOS when the size is
   252                           * zero.
   253                           */
   254                          if (int_value == 0)
   255                                  eloc++;
   256                          break;
   257                  case ORD_LIST_ELEMENTS:
   258                          size = ordered_list_data->elements_size;

We don't use size anywhere so this can be deleted.

   259  
   260                          /*
   261                           * Ordered list data is stored in hex and comma separated format
   262                           * Convert the data and split it to show each element
   263                           */
   264                          ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);

The value_len here is wrong.  We don't read value_len for ORD_LIST_ELEMENTS
or PREREQUISITES so this value_len comes from the PATH object.

   265                          if (ret)
   266                                  goto exit_list;
   267  
   268                          part_tmp = tmpstr;
   269                          part = strsep(&part_tmp, COMMA_SEP);
   270                          if (!part)
   271                                  strscpy(ordered_list_data->elements[0],
   272                                          tmpstr,
   273                                          sizeof(ordered_list_data->elements[0]));
   274  
   275                          for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {

Please don't re-use the "elem" iterator for this inner loop.

regards,
dan carpenter

   276                                  strscpy(ordered_list_data->elements[elem],
   277                                          part,
   278                                          sizeof(ordered_list_data->elements[elem]));
   279                                  part = strsep(&part_tmp, SEMICOLON_SEP);
   280                          }
   281
   282                          kfree(str_value);
   283                          str_value = NULL;
   284                          break;
   285                  default:
   286                          pr_warn("Invalid element: %d found in Ordered_List attribute or data may be malformed\n", elem);
   287                          break;
   288                  }
   289                  kfree(tmpstr);
   290                  tmpstr = NULL;
   291                  kfree(str_value);
   292                  str_value = NULL;
   293          }
   294
   295  exit_list:
   296          kfree(tmpstr);
   297          kfree(str_value);
   298          return 0;
   299  }


